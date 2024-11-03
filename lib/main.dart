import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waveconnect/responsive/mobile_screen_layout.dart';
import 'package:waveconnect/responsive/responsive_layout_screen.dart';
import 'package:waveconnect/responsive/web_screen_layout.dart';
import 'package:waveconnect/screens/login_screen.dart';
import 'package:waveconnect/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyACEV7-CUuTyTVEsUBIwHMqBnHr--DHEKI",
        appId: "1:946834348663:web:c7b2f2ba04be8f5d3e4472",
        messagingSenderId: "946834348663",
        projectId: "waveconnect101",
        storageBucket: "waveconnect101.firebasestorage.app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaveConnect',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobilescreenlayout: MobileScreenLayout(),
      //   webscreenlayout: WebScreenLayout(),
      // ),

      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobilescreenlayout: MobileScreenLayout(),
                  webscreenlayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }

            return const LoginScreen();
          }),
    );
  }
}
