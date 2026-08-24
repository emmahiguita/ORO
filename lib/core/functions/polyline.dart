import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/constant/apikey.dart';
import 'package:http/http.dart' as http;
import 'package:oro/core/constant/color.dart';

Future<Set<Polyline>> getPolyLine(lat, long, destlat, destlong) async {
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=${ApiKeys.gMap}";

  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        var points = data['routes'][0]['overview_polyline']['points'];
        List<PointLatLng> result = polylinePoints.decodePolyline(points);
        for (var point in result) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print("No route found, falling back to straight line");
        // Fallback to straight line if no route found
        polylineCoordinates = [LatLng(lat, long), LatLng(destlat, destlong)];
      }

      Polyline polyline = Polyline(
        polylineId: const PolylineId("polyline"),
        color: Appcolor.berry,
        width: 5,
        points: polylineCoordinates,
        geodesic: true, // Important for straight lines over sea
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
      );
      polylineSet.add(polyline);
    } else {
      print("Error: ${response.statusCode}");
      // Fallback to straight line on error
      polylineSet.add(Polyline(
        polylineId: const PolylineId("fallback_polyline"),
        points: [LatLng(lat, long), LatLng(destlat, destlong)],
        color: Appcolor.berry,
        width: 5,
        geodesic: true,
      ));
    }
  } catch (e) {
    print("Error getting polyline: $e");
    // Fallback to straight line on exception
    polylineSet.add(Polyline(
      polylineId: const PolylineId("error_polyline"),
      points: [LatLng(lat, long), LatLng(destlat, destlong)],
      color: Appcolor.berry,
      width: 5,
      geodesic: true,
    ));
  }

  return polylineSet;
}
