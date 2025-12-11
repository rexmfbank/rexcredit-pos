// import 'package:geolocator/geolocator.dart';

// class LocationState {
//   final Position? currentPosition;
//   final bool? hasPermission;
//   final bool isLoading;
//   final String? errorMessage;
//   final bool isPermissionPermanentlyDenied;
//   final bool isLocationServiceEnabled;

//   const LocationState({
//     this.currentPosition,
//     this.hasPermission,
//     this.isLoading = false,
//     this.errorMessage,
//     this.isPermissionPermanentlyDenied = false,
//     this.isLocationServiceEnabled = false,
//   });

//   LocationState copyWith({
//     Position? currentPosition,
//     bool? hasPermission,
//     bool? isLoading,
//     String? errorMessage,
//     bool? isPermissionPermanentlyDenied,
//     bool? isLocationServiceEnabled,
//   }) {
//     return LocationState(
//         currentPosition: currentPosition ?? this.currentPosition,
//         hasPermission: hasPermission ?? this.hasPermission,
//         isLoading: isLoading ?? this.isLoading,
//         errorMessage: errorMessage ?? this.errorMessage,
//         isPermissionPermanentlyDenied:
//             isPermissionPermanentlyDenied ?? this.isPermissionPermanentlyDenied,
//         isLocationServiceEnabled:
//             isLocationServiceEnabled ?? this.isLocationServiceEnabled);
//   }

//   // Helper getters
//   // bool get isPermissionGranted => hasPermission == true;
//   // bool get locationEnabled => isLocationServiceEnabled == true;
//   // bool get isPermissionDenied => hasPermission == false;
//   // bool get hasLocation => currentPosition != null;
//   // bool get shouldShowSettingsDialog => isPermissionPermanentlyDenied;

//   @override
//   String toString() {
//     return 'LocationState(currentPosition: $currentPosition, hasPermission: $hasPermission, isLoading: $isLoading, errorMessage: $errorMessage, isPermissionPermanentlyDenied: $isPermissionPermanentlyDenied)';
//   }
// }
