import 'dart:async';

import 'package:dealz/common/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  final Function(String, Coordinates)? setAddress;

  AddAddressScreen({Key? key, this.setAddress}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => MapSampleState();
}

class MapSampleState extends State<AddAddressScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Type? currentLocation;
  var lpr;
  bool isNavigated = false;
  var myMarker = Marker(
    markerId: MarkerId("1"),
  );
  String? address;
  String? addressDetails;
  List<Placemark>? newPlace;
  Coordinates? coordinates;

  var addressNameTFC = new TextEditingController();
  var addressFloorTFC = new TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.8206, 30.8025),
    zoom: 18.4746,
  );

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                getCurrentLocation();
              },
              myLocationButtonEnabled: false,
              onTap: (location) async {
                setState(() {
                  var myCameraPosition =
                      CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: 17.151926040649414);
                  myMarker = myMarker.copyWith(positionParam: LatLng(location.latitude, location.longitude));

                  _controller.future.then((controller) {
                    controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
                  });
                });
                coordinates = new Coordinates(latitude: location.latitude, longitude: location.longitude);
                newPlace = await placemarkFromCoordinates(location.latitude, location.longitude);
                setState(() {
                  this.addressDetails =
                      newPlace![0].street! + ", " + newPlace![0].administrativeArea! + ", " + newPlace![0].country!;
                  this.address = newPlace![0].administrativeArea! + ", " + newPlace![0].country!;
                });
              },
              myLocationEnabled: true,
              markers: Set.of(
                [myMarker],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height - 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      elevation: 3.0,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0, bottom: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  "إختار موقعك",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: addressDetails != null,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height: 80.0,
                                margin: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!, width: 1.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.my_location,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width - 85,
                                            child: Text(
                                              addressDetails ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          address == null ? "" : "$address",
                                          style: TextStyle(color: Colors.grey[500], fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        mini: true,
                        child: Icon(
                          Icons.my_location,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          getCurrentLocation();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0, bottom: 80.0),
                      child: InkWell(
                        onTap: () {
                          if (coordinates == null) {
                            return showToast("من فضلك اختر موقع");
                          } else {
                            widget.setAddress!(addressDetails!, coordinates!);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "تأكيد",
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        showToast("فعل الموقع لاستخدام التطبيق");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showToast("من من فضلك قم بتفعيل الموقع من الاعدادات");
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Geolocator.getCurrentPosition().then((location) async {
      _controller.future.then((controller) {
        var myCameraPosition =
        CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: 17.151926040649414);

        setState(() {
          myMarker = myMarker.copyWith(positionParam: LatLng(location.latitude, location.longitude));
        });
        controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
      });
      coordinates = new Coordinates(latitude: location.latitude, longitude: location.longitude);
      newPlace = await placemarkFromCoordinates(location.latitude, location.longitude);
      setState(() {
        this.addressDetails =
            newPlace![0].street! + ", " + newPlace![0].administrativeArea! + ", " + newPlace![0].country!;
        this.address = newPlace![0].administrativeArea! + ", " + newPlace![0].country!;
      });
    });
  }
}
