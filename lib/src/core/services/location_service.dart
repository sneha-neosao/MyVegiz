import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  /// Check and request location permission
  static Future<LocationPermission> checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // User has permanently denied → open settings
      await Geolocator.openAppSettings();
    }

    return permission;
  }

  /// Ensure location services (GPS) are enabled
  static Future<bool> ensureServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  /// Get current position
  static Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (_) {
      return await Geolocator.getLastKnownPosition();
    }
  }

  /// Convert lat/lng → address
  static Future<String> getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];
    return "${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  /// Save location to SharedPreferences
  static Future<void> saveLocation(Position position, String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('latitude', position.latitude.toString());
    await prefs.setString('longitude', position.longitude.toString());
    await prefs.setString('address', address);
  }

  /// Load saved location
  static Future<({double? lat, double? lng, String? address})> loadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final latStr = prefs.getString('latitude');
    final lngStr = prefs.getString('longitude');
    final address = prefs.getString('address');
    return (
    lat: latStr != null ? double.tryParse(latStr) : null,
    lng: lngStr != null ? double.tryParse(lngStr) : null,
    address: address
    );
  }
}
