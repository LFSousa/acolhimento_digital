import 'dart:async';

import 'package:acolhimento_digital/app/presentation/controllers/map_controller.dart';
import 'package:acolhimento_digital/app/presentation/extensions/loading_extension.dart';
import 'package:acolhimento_digital/app/presentation/pages/map/widgets/favorite_list.dart';
import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:acolhimento_digital/di/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'widgets/place_sheet.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapView(getIt<MapController>());
  }
}

class MapView extends StatefulWidget {
  const MapView(this.controller, {Key? key}) : super(key: key);

  final MapController controller;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) => start());
  }

  Future<void> onMarkerPressed(Place place) async {
    await showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => PlaceSheet(place, onFavorite: () {
        place.favorite = true;
        controller.addFavorite(place.id!);
      }, onUnFavorite: () {
        place.favorite = false;
        controller.removeFavorite(place.id!);
      }),
    );
  }

  Future<void> start() async {
    controller.onMarkerPressed = onMarkerPressed;
    context.showLoading();
    var placesResponse = await controller.loadPlaces();
    await _controller.future;
    context.dismissLoading();
    placesResponse.fold((l) => null, (r) {
      controller.setPlaces(r);
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _manaus = const CameraPosition(
    target: LatLng(-3.10194, -60.025),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var place = await showMaterialModalBottomSheet<Place?>(
            context: context,
            backgroundColor: Colors.transparent,
            expand: true,
            builder: (context) => FavoriteListSheet(controller.favorites),
          );

          if (place != null) {
            var map = await _controller.future;
            await map.animateCamera(CameraUpdate.newLatLng(place.latLng));
            await onMarkerPressed(place);
          }
        },
        backgroundColor: const Color(0xfffe6265),
        child: const Icon(CupertinoIcons.star_fill),
      ),
      body: Observer(builder: (_) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _manaus,
          onMapCreated: _controller.complete,
          markers: controller.markers,
          zoomControlsEnabled: false,
          compassEnabled: false,
          myLocationEnabled: true,
        );
      }),
    );
  }
}
