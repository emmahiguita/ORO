import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/address/updateaddresscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/screens/address/updateadressmap.dart';

class UpdateAdress extends StatelessWidget {
  const UpdateAdress({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(UpdateAddressControllerImp());
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<UpdateAddressControllerImp>(
        builder: (controller) {
          // Create a GlobalKey for the GoogleMap widget
          final GlobalKey<GoogleMapState> mapKey = GlobalKey();

          // Camera position with current coordinates
          final cameraPosition = CameraPosition(
            target: LatLng(controller.lat ?? 0, controller.long ?? 0),
            zoom: 14.4746,
          );

          return ListView(
            children: [
              InkWell(
                onTap: () async {
                  final result =
                      await Get.to(() => const UpdateAddressMap(), arguments: {
                    "oldlat": controller.lat,
                    "oldlong": controller.long,
                    "oldmarker": controller.markers,
                  });

                  if (result != null) {
                    controller.updateMapLocation(
                      result["newlat"],
                      result["newlong"],
                      result["newplacename"],
                      result["newmarker"],
                    );

                    // Move camera to new position after update
                    final googleMapState = mapKey.currentState;
                    if (googleMapState != null) {
                      googleMapState.moveCamera(
                        CameraUpdate.newLatLng(
                          LatLng(result["newlat"], result["newlong"]),
                        ),
                      );
                    }
                  }
                },
                child: IgnorePointer(
                  child: Container(
                    height: 150,
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: GoogleMap(
                      key: mapKey, // Assign the key to the GoogleMap
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      mapToolbarEnabled: false,
                      tiltGesturesEnabled: false,
                      mapType: MapType.normal,
                      markers: controller.markers ?? {},
                      initialCameraPosition: cameraPosition,
                      onMapCreated: (GoogleMapController googleMapController) {
                        // Immediately move to the correct position when map is created
                        googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(cameraPosition),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Form(
                  key: controller.formkey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: controller.addressName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Appcolor.deepRed,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: const Text(
                                "Address name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: controller.buildingName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Appcolor.deepRed,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: const Text(
                                "Building name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                controller: controller.aptNumber,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Appcolor.deepRed,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                    label: const Text(
                                      "Apt. number",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                controller: controller.floor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Appcolor.deepRed,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                    label: const Text(
                                      "Floor",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: controller.street,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Appcolor.deepRed,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              label: const Text(
                                "Street",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                controller: controller.block,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Appcolor.deepRed,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                    label: const Text(
                                      "Block",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                controller: controller.way,
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Appcolor.deepRed,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(15),
                                  label: const Text(
                                    "Way (optional)",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  controller: controller.additionalDetails,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Appcolor.deepRed,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    label: const Text(
                      "Additional directions (optional)",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Appcolor.deepRed,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Appcolor.shadowPink,
                    onTap: () async {
                      controller.updateData();
                    },
                    child: const Center(
                      child: Text(
                        "Update Address",
                        style: TextStyle(
                          fontSize: 20,
                          color: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class GoogleMapState extends State<GoogleMap> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
        if (widget.onMapCreated != null) {
          widget.onMapCreated!(controller);
        }
      },
      // Pass through all other GoogleMap properties
      initialCameraPosition: widget.initialCameraPosition,
      markers: widget.markers,
      zoomControlsEnabled: widget.zoomControlsEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      mapToolbarEnabled: widget.mapToolbarEnabled,
      tiltGesturesEnabled: widget.tiltGesturesEnabled,
      mapType: widget.mapType,
    );
  }

  void moveCamera(CameraUpdate update) {
    _controller?.animateCamera(update);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
