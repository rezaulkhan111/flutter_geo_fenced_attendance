import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

enum AttendanceStatus { initial, loading, success, failure, markingSuccess }

class AttendanceState extends Equatable {
  final Position? officeLocation;
  final Position? userLocation;
  final double? distance;
  final AttendanceStatus status;
  final String? errorMessage;
  final bool attendanceMarked;
  final bool isInRange;

  const AttendanceState({
    this.officeLocation,
    this.userLocation,
    this.distance,
    this.status = AttendanceStatus.initial,
    this.errorMessage,
    this.attendanceMarked = false,
    this.isInRange = false,
  });

  AttendanceState copyWith({
    Position? officeLocation,
    Position? userLocation,
    double? distance,
    AttendanceStatus? status,
    String? errorMessage,
    bool? attendanceMarked,
    bool? isInRange,
  }) {
    return AttendanceState(
      officeLocation: officeLocation ?? this.officeLocation,
      userLocation: userLocation ?? this.userLocation,
      distance: distance ?? this.distance,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      attendanceMarked: attendanceMarked ?? this.attendanceMarked,
      isInRange: isInRange ?? this.isInRange,
    );
  }

  @override
  List<Object?> get props => [
    officeLocation,
    userLocation,
    distance,
    status,
    errorMessage,
    attendanceMarked,
    isInRange,
  ];
}
