import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../data/location_repository.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final LocationRepository _locationRepository;
  StreamSubscription<Position>? _positionSubscription;

  AttendanceBloc(this._locationRepository) : super(const AttendanceState()) {
    on<LoadOfficeLocation>(_onLoadOfficeLocation);
    on<SetOfficeLocation>(_onSetOfficeLocation);
    on<TrackUserLocation>(_onTrackUserLocation);
    on<UpdateUserLocation>(_onUpdateUserLocation);
    on<MarkAttendance>(_onMarkAttendance);
  }

  Future<void> _onLoadOfficeLocation(
    LoadOfficeLocation event,
    Emitter<AttendanceState> emit,
  ) async {
    final officeLocation = await _locationRepository.getSavedOfficeLocation();
    emit(state.copyWith(officeLocation: officeLocation));
    add(TrackUserLocation());
  }

  Future<void> _onSetOfficeLocation(
    SetOfficeLocation event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      final position = await _locationRepository.getCurrentLocation();
      await _locationRepository.saveOfficeLocation(
        position.latitude,
        position.longitude,
      );
      emit(
        state.copyWith(
          officeLocation: position,
          status: AttendanceStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AttendanceStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onTrackUserLocation(
    TrackUserLocation event,
    Emitter<AttendanceState> emit,
  ) {
    _positionSubscription?.cancel();
    _positionSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 1,
          ),
        ).listen((Position position) {
          double? distance;
          if (state.officeLocation != null) {
            distance = _locationRepository.calculateDistance(
              position.latitude,
              position.longitude,
              state.officeLocation!.latitude,
              state.officeLocation!.longitude,
            );
          }
          add(UpdateUserLocation(position, distance));
        });
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<AttendanceState> emit,
  ) {
    emit(
      state.copyWith(
        userLocation: event.userLocation,
        distance: event.distance,
      ),
    );
  }

  Future<void> _onMarkAttendance(
    MarkAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.distance != null && state.distance! <= 50.0) {
      emit(
        state.copyWith(
          attendanceMarked: true,
          status: AttendanceStatus.markingSuccess,
        ),
      );
      // Immediately reset status to success so the listener doesn't re-trigger
      emit(state.copyWith(status: AttendanceStatus.success));
    } else {
      emit(
        state.copyWith(
          status: AttendanceStatus.failure,
          errorMessage: 'You are out of range.',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
