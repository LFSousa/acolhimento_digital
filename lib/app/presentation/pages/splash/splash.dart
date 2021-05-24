import 'package:acolhimento_digital/app/presentation/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => context.router.replace(const WelcomeRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/splash.jpeg',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
