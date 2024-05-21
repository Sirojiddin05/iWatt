enum LocationPermissionStatus {
  initial,
  locationServiceDisabled,
  permissionDenied,
  permissionGranted;

  bool get isInitial => this == LocationPermissionStatus.initial;
  bool get isLocationServiceDisabled => this == LocationPermissionStatus.locationServiceDisabled;
  bool get isPermissionDenied => this == LocationPermissionStatus.permissionDenied;
  bool get isPermissionGranted => this == LocationPermissionStatus.permissionGranted;
}
