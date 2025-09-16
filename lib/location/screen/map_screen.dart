import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/location/firestore_service.dart';
import 'package:foodapp/location/service/stream_location_service.dart';
import 'package:foodapp/location/user/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(
      -18.9216855,
      47.5725194,
    ), // Antananarivo, Madagascar LatLng 🇲🇬
    zoom: 14.4746,
  );

  late StreamSubscription<Position>? locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    locationStreamSubscription = StreamLocationService.onLocationChanged?.listen((
      position,
    ) async {
      await FirestoreService.updateUserLocation(
        'wsgAwLQruHmsE5cDlnpo', //Hardcoded uid but this is the uid of the connected user when using authentification service
        LatLng(position.latitude, position.longitude),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<User>>(
        stream: FirestoreService.userCollectionStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          final Set<Marker> markers = {};
          for (var i = 0; i < snapshot.data!.length; i++) {
            final user = snapshot.data![i];
            markers.add(
              Marker(
                markerId: MarkerId('${user.name} position $i'),
                icon: user.name == 'ajlan'
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      )
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueYellow,
                      ),
                position: LatLng(user.location.lat, user.location.lng),
                onTap: () => {},
              ),
            );
          }
          return GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    locationStreamSubscription?.cancel();
  }
}
