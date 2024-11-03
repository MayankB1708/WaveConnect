import 'package:flutter/material.dart';
import 'package:waveconnect/responsive/mobile_screen_layout.dart';
import 'package:waveconnect/responsive/responsive_layout_screen.dart';
import 'package:waveconnect/responsive/web_screen_layout.dart';
import 'package:waveconnect/utils/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaveConnect',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor,),
      home:const ResponsiveLayout(
        mobilescreenlayout: MobileScreenLayout(), 
        webscreenlayout: WebScreenLayout(),
        ),
    );
  }
}
