import 'package:flutter/material.dart';

import '../../AppColors.dart';

class WatchlistTab extends StatelessWidget {
  static const String routeName = "watch_list";
  const WatchlistTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
    );
  }
}
