import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationState extends Equatable {
  final Position? currentPosition;
  final List<Placemark>? placeMark;
  final bool? hasPermission;
  final bool isLoading;
  final String? errorMessage;
  final bool isPermissionPermanentlyDenied;
  final bool isLocationServiceEnabled;

  const LocationState({
    this.currentPosition,
    this.placeMark,
    this.hasPermission,
    this.isLoading = false,
    this.errorMessage,
    this.isPermissionPermanentlyDenied = false,
    this.isLocationServiceEnabled = false,
  });

  LocationState copyWith({
    Position? currentPosition,
    List<Placemark>? placeMark,
    bool? hasPermission,
    bool? isLoading,
    String? errorMessage,
    bool? isPermissionPermanentlyDenied,
    bool? isLocationServiceEnabled,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      hasPermission: hasPermission ?? this.hasPermission,
      isLoading: isLoading ?? this.isLoading,
      placeMark: placeMark ?? this.placeMark,
      errorMessage: errorMessage ?? this.errorMessage,
      isPermissionPermanentlyDenied:
          isPermissionPermanentlyDenied ?? this.isPermissionPermanentlyDenied,
      isLocationServiceEnabled:
          isLocationServiceEnabled ?? this.isLocationServiceEnabled,
    );
  }

  @override
  List<Object?> get props => [
    currentPosition,
    placeMark,
    hasPermission,
    isLoading,
    errorMessage,
    isPermissionPermanentlyDenied,
    isLocationServiceEnabled,
  ];
}
