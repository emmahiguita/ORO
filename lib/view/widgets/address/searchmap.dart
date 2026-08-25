import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/address/addaddresscontroller.dart';
import 'package:oro/controller/address/updatemapcontroller.dart';
import 'package:oro/core/constant/apikey.dart';

class SearchMap extends StatelessWidget {
  final String googleApiKey = ApiKeys.gMap;

  const SearchMap({super.key});

  @override
  Widget build(BuildContext context) {
    final places = GoogleMapsPlaces(apiKey: googleApiKey);
    final dynamic mapController;

    if (Get.isRegistered<AddAddressControllerImp>()) {
      mapController = Get.find<AddAddressControllerImp>();
    } else if (Get.isRegistered<UpdateMapControllerImp>()) {
      mapController = Get.find<UpdateMapControllerImp>();
    } else {
      throw Exception(
          "Neither AddAddressControllerImp nor UpdateMapControllerImp is registered");
    }

    return TypeAheadField<Prediction>(
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            hintText: 'Search location',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            ),
            hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).disabledColor,
                ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 20,
              ),
        );
      },
      itemBuilder: (context, Prediction suggestion) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                suggestion.description ?? 'No description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 20,
                    ),
              ),
            ),
          ]),
        );
      },
      onSelected: (Prediction suggestion) async {
        try {
          final details = await places.getDetailsByPlaceId(
            suggestion.placeId!,
            language: 'en',
          );
          if (details.result.geometry != null) {
            final location = details.result.geometry!.location;
            final latLng = LatLng(location.lat, location.lng);
            final GoogleMapController controller =
                await mapController.googleMapController!.future;
            await controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: latLng,
                  zoom: 16,
                ),
              ),
            );
          }
        } catch (e) {
          debugPrint("Error getting place details: $e");
        }
      },
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) return <Prediction>[];

        try {
          final response = await places.autocomplete(
            pattern,
            language: 'en',
          );

          if (response.isOkay) {
            return response.predictions;
          } else {
            debugPrint("Places API error: ${response.errorMessage}");
            return <Prediction>[];
          }
        } catch (e) {
          debugPrint("Error fetching places: $e");
          return <Prediction>[];
        }
      },
    );
  }
}
