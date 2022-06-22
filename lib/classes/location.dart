// //Not Used
// import 'package:geocode/geocode.dart';
// import 'package:geolocator/geolocator.dart';
//
// class Location {
//   late double longitude;
//   late double latitude;
//   late String countryName;
//
//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       latitude = position.latitude;
//       longitude = position.longitude;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<String?> getCountryName() async {
//     LocationPermission permission;
//     permission = await Geolocator.requestPermission();
//     GeoCode geoCode = GeoCode();
//     Address coordinates = await geoCode.reverseGeocoding(
//         latitude: latitude, longitude: longitude);
//     String? country = coordinates.countryName.toString();
//     return country;
//   }
// }
