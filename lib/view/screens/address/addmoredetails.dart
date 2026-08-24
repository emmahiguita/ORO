import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/address/addmoredetailscontroller.dart';
import 'package:oro/core/constant/color.dart';

class AddMoreDetails extends StatelessWidget {
  const AddMoreDetails({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AddMoreDetailsControllerImp());
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<AddMoreDetailsControllerImp>(
          builder: (controller) => ListView(
            children: [
              Container(
                height: 150,
                margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  mapToolbarEnabled: false,
                  tiltGesturesEnabled: false,
                  mapType: MapType.normal,
                  markers: controller.markers!,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(controller.lat!, controller.long!),
                    zoom: 14.4746,
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
              const SizedBox(
                height: 10,
              ),
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
                    onTap: () {
                      controller.sendData();
                    },
                    child: const Center(
                      child: Text(
                        "Add address",
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
          ),
        ));
  }
}
