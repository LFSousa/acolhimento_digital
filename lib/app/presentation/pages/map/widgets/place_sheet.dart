import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PlaceSheet extends StatefulWidget {
  const PlaceSheet(
    this.place, {
    Key? key,
    required this.onFavorite,
    required this.onUnFavorite,
  }) : super(key: key);

  final Place place;
  final VoidCallback onFavorite;
  final VoidCallback onUnFavorite;

  @override
  _PlaceSheetState createState() => _PlaceSheetState();
}

class _PlaceSheetState extends State<PlaceSheet> {
  var favorite = false;

  @override
  void initState() {
    favorite = widget.place.favorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff101010).withOpacity(0.3),
                          const Color(0xff010101).withOpacity(0.4),
                        ],
                        stops: [0, 0.5],
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.place.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.place.name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30),
                    width: MediaQuery.of(context).size.width / 0.7,
                    child: Text(
                      widget.place.address,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xff2C1654).withOpacity(.5),
                    elevation: 0,
                    child: const Icon(CupertinoIcons.arrow_right),
                    onPressed: () async {
                      final title = widget.place.name;
                      final coords = Coords(widget.place.latLng.latitude, widget.place.latLng.longitude);
                      final availableMaps = await MapLauncher.installedMaps;

                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    for (var map in availableMaps)
                                      ListTile(
                                        onTap: () => map.showMarker(
                                          coords: coords,
                                          title: title,
                                        ),
                                        title: Text(map.mapName),
                                        leading: SvgPicture.asset(
                                          map.icon,
                                          width: 50,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.maxFinite,
              color: const Color(0xff2c1654),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        Text(
                          'CEP:\n${widget.place.cep}',
                          style: const TextStyle(color: Color(0xfffe6265), fontWeight: FontWeight.w800, fontSize: 22),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: Icon(favorite ? CupertinoIcons.star_fill : CupertinoIcons.star, color: const Color(0xfffe6265), size: 40),
                          onPressed: () {
                            if (favorite) {
                              widget.onUnFavorite();
                            } else {
                              widget.onFavorite();
                            }
                            setState(() {
                              favorite ^= true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_android_outlined, color: Color(0xfffe6265), size: 50),
                        Text(
                          'Telefone:\n${widget.place.phone}',
                          style: const TextStyle(color: Color(0xfffe6265), fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
