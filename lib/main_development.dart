import 'dart:async';
import 'dart:developer';

import 'package:acolhimento_digital/app/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'di/di.dart';

Future<void> main() async {
  configureDependencies('development');
  await Firebase.initializeApp();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
