import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:foodapp/consts/constants.dart';
import 'package:foodapp/order/views/rider_info_card.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingView extends StatefulWidget {
  const OrderTrackingView({super.key});

  @override
  State<OrderTrackingView> createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  final Completer<GoogleMapController> _googleMapController = Completer();

  LatLng sourceLocation = LatLng(37.33500926, -122.032728);
  LatLng destiLocation = LatLng(37.33429383, -122.06600055);
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  //  void setCustonIcon()async{

  //   try{
  //   final iconResult=await Future.wait({
  //    BitmapDescriptor.asset(ImageConfiguration(size: Size(15,29))
  //    , 'assets/Pin_source.png'),
  //    BitmapDescriptor.asset(ImageConfiguration(size: Size(24,28))
  //    , 'assets/Pin_source.png')
  //   });
  //   setState(() {
  //     sourceIcon=iconResult[1];
  //     destinationIcon=iconResult[1];
  //   });
  //   }catch(e){
  //   print(e.toString());
  //   }

  //  }

  final PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> polyPoints = [];

  void getPolyPoints() async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: google_api_key,
        request: PolylineRequest(
          origin: PointLatLng(
            sourceLocation.latitude,
            sourceLocation.longitude,
          ),
          destination: PointLatLng(
            destiLocation.latitude,
            destiLocation.longitude,
          ),
          mode: TravelMode.driving,
          optimizeWaypoints: true,
        ),
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polyPoints = result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final Location _locaton = Location();
  LocationData? locationData;

  void getCurrentLocation() async {
    try {
      LocationData currentLoc = await _locaton.getLocation();
      setState(() {
        locationData = currentLoc;
      });

      final GoogleMapController controller = await _googleMapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLoc.latitude!, currentLoc.longitude!),
            zoom: 14.5,
            tilt: 59,
            bearing: -70,
          ),
        ),
      );

      _locaton.onLocationChanged.listen((LocationData newLocation) async {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocation.latitude!, newLocation.longitude!),
              zoom: 14.5,
              tilt: 59,
              bearing: -70,
            ),
          ),
        );
        setState(() {
          locationData=newLocation;
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    //  setCustonIcon();
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accessToken=GetStorage().read('accessToken');

    // if(accessToken==null){
    //   return ;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Live Tracking'),
      centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 13.5,
              ),
              onMapCreated: (controller) {
                _googleMapController.complete(controller);
              },
              markers: {
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  position: destiLocation,
                  icon: destinationIcon,
                ),
                if (locationData != null)
                  Marker(
                    markerId: MarkerId("currentLocation"),
                    position: LatLng(
                      locationData!.latitude!,
                      locationData!.longitude!,
                    ),
                    
                  ),
               
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polyPoints,
                  width: 6,
                  color: Colors.blue,
                ),
              },
            ),
          ),
          RiderInfoCard(riderName: 'Tamim Ahmed',
           distanceInMeters: 122,
           
           )
        ],
      ),
    );
  }
}
