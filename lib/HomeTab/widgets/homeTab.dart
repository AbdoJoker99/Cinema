import 'package:flutter/material.dart';

import '../../AppColors.dart';

class Hometab extends StatelessWidget {
  static const String routeName = "homeTab";
  const Hometab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("homeTab"),
      ),
    );
  }
}
