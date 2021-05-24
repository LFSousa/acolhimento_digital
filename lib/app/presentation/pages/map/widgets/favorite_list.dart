import 'package:acolhimento_digital/app/repositories/places/models/place_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteListSheet extends StatefulWidget {
  FavoriteListSheet(this.favorites, {Key? key}) : super(key: key);
  final List<Place> favorites;

  @override
  _FavoriteListSheetState createState() => _FavoriteListSheetState();
}

class _FavoriteListSheetState extends State<FavoriteListSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2c1654),
      appBar: AppBar(
        backgroundColor: const Color(0xff2c1654),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const Icon(CupertinoIcons.star, size: 30, color: Color(0xffF28589)),
        title: const Text('FAVORITOS', style: TextStyle(color: Color(0xffF28589))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(CupertinoIcons.xmark_circle_fill, size: 30),
              onPressed: () => Navigator.pop(context),
              color: const Color(0xffF28589),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xff2c1654),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/favoritos.png',
                  width: 250,
                ),
              ),
              for (var favorite in widget.favorites)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pop(context, favorite),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.star_fill, size: 30, color: Color(0xffF28589)),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            favorite.name,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
