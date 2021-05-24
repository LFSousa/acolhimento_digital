import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.value}) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}
