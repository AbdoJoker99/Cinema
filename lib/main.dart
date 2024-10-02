import 'package:cinema/splashScreen/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BrowserScreen/Widgets/browserDetails.dart';
import 'BrowserScreen/Widgets/browserTabScreen.dart';
import 'HomeTab/widgets/homeTab.dart';
import 'MovieDetails(homeTab)/movie_details_screen.dart';
import 'SerchScreen/Widgets/searchSceenTab.dart';
import 'WatchList/watchListTab.dart';
import 'homeScreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
          initialRoute: SplashScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            BrowserDetails.routeName: (context) => BrowserDetails(),
            SplashScreen.routeName: (context) => SplashScreen(),
            Hometab.routeName: (context) => Hometab(),
            Searchsceentab.routeName: (context) => Searchsceentab(),
            WatchListTab.routeName: (context) => WatchListTab(),
            BrowserTabScreen.routeName: (context) => BrowserTabScreen(),
            MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(
                movieId: ModalRoute.of(context)!.settings.arguments as int)
          },
        );
      },
    );
  }
}
