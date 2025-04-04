import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waveconnect/providers/user_provider.dart';
import 'package:waveconnect/utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webscreenlayout;
  final Widget mobilescreenlayout;
  const ResponsiveLayout({
    Key? key,
    required this.webscreenlayout,
    required this.mobilescreenlayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webscreensize) {
        //web screen
        return widget.webscreenlayout;
      }

      //mobile screen
      return widget.mobilescreenlayout;
    });
  }
}
