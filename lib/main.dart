import 'package:cinema/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BrowserScreen/Widgets/browserTabScreen.dart';
import 'HomeTab/widgets/homeTab.dart';
import 'SerchScreen/Widgets/searchSceenTab.dart';
import 'WatchList/Widgets/watchListTab.dart';
import 'homeScreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            Hometab.routeName: (context) => Hometab(),
            Searchsceentab.routeName: (context) => Searchsceentab(),
            WatchlistTab.routeName: (context) => WatchlistTab(),
            BrowserTabScreen.routeName: (context) => BrowserTabScreen(),
          },
        );
      },
    );
  }
}
