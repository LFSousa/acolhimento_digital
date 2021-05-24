import 'dart:io';

import 'package:acolhimento_digital/app/presentation/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool _isLoading = false;

extension LoadingExtension on BuildContext {
  bool get isLoading => _isLoading;

  void showLoading() {
    if (_isLoading) return;
    _isLoading = true;
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: kIsWeb || Platform.isAndroid
            ? const AlertDialog(
                title: Center(
                  child: Loader(),
                ),
              )
            : const CupertinoAlertDialog(
                title: Center(
                  child: Loader(),
                ),
              ),
      ),
    );
  }

  void dismissLoading() {
    if (!_isLoading) return;
    _isLoading = false;
    Navigator.pop(this);
  }
}
