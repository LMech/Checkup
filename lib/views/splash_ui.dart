import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                ),
              ),
              Expanded(
                child: Text(
                  'CHECKUP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
