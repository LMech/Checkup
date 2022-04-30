import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.indigo, Colors.indigoAccent])),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.scaleDown,
                width: 200.0,
                height: 200.0,
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.9),
              child: Text(
                'CHECKUP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
