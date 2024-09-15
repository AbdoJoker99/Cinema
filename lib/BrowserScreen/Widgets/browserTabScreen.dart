import 'package:cinema/AppColors.dart';
import 'package:flutter/material.dart';

class BrowserTabScreen extends StatelessWidget {
  static const String routeName = "browser";
  const BrowserTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("BrowserScreenTab"),
      ),
    );
  }
}
