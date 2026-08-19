import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadOfficeLocation extends AttendanceEvent {}

class SetOfficeLocation extends AttendanceEvent {}

class TrackUserLocation extends AttendanceEvent {}

class UpdateUserLocation extends AttendanceEvent {
  final Position userLocation;
  final double? distance;

  const UpdateUserLocation(this.userLocation, this.distance);

  @override
  List<Object?> get props => [userLocation, distance];
}

class MarkAttendance extends AttendanceEvent {}
