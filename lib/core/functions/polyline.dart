import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/constant/apikey.dart';
import 'package:http/http.dart' as http;
import 'package:oro/core/constant/color.dart';

Future<Set<Polyline>> getPolyLine(
    dynamic lat, dynamic long, dynamic destlat, dynamic destlong) async {
  if (lat == null || long == null || destlat == null || destlong == null) {
    return {};
  }

  final double? startLat =
      lat is num ? lat.toDouble() : double.tryParse('$lat');
  final double? startLong =
      long is num ? long.toDouble() : double.tryParse('$long');
  final double? endLat =
      destlat is num ? destlat.toDouble() : double.tryParse('$destlat');
  final double? endLong =
      destlong is num ? destlong.toDouble() : double.tryParse('$destlong');

  if (startLat == null ||
      startLong == null ||
      endLat == null ||
      endLong == null) {
    return {};
  }

  Set<Polyline> polylineSet = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLong&destination=$endLat,$endLong&key=${ApiKeys.gMap}";

  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK' &&
          data['routes'] is List &&
          data['routes'].isNotEmpty) {
        var points = data['routes'][0]['overview_polyline']['points'];
        List<PointLatLng> result = polylinePoints.decodePolyline(points);
        for (var point in result) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        polylineCoordinates = [
          LatLng(startLat, startLong),
          LatLng(endLat, endLong),
        ];
      }

      Polyline polyline = Polyline(
        polylineId: const PolylineId("polyline"),
        color: Appcolor.berry,
        width: 5,
        points: polylineCoordinates,
        geodesic: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
      );
      polylineSet.add(polyline);
    } else {
      debugPrint("Polyline HTTP Error: ${response.statusCode}");
      polylineSet.add(Polyline(
        polylineId: const PolylineId("fallback_polyline"),
        points: [LatLng(startLat, startLong), LatLng(endLat, endLong)],
        color: Appcolor.berry,
        width: 5,
        geodesic: true,
      ));
    }
  } catch (e) {
    debugPrint("Error getting polyline: $e");
    polylineSet.add(Polyline(
      polylineId: const PolylineId("error_polyline"),
      points: [LatLng(startLat, startLong), LatLng(endLat, endLong)],
      color: Appcolor.berry,
      width: 5,
      geodesic: true,
    ));
  }

  return polylineSet;
}
