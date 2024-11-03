import 'package:flutter/material.dart';
import 'package:waveconnect/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webscreenlayout;
  final Widget mobilescreenlayout;
  const ResponsiveLayout({
    Key? key,
    required this.webscreenlayout,
    required this.mobilescreenlayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webscreensize) {
        //web screen
        return webscreenlayout;
      }

      //mobile screen
      return mobilescreenlayout;
    });
  }
}
