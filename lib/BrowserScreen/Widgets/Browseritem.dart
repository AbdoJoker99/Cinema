import 'package:cinema/myAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dataBrowser/responseBrowser/browserDiscoveryRespone.dart';
import '../dataBrowser/responseBrowser/browserResponse.dart';

class BrowserItem extends StatelessWidget {
  final Browser? browser;
  final reselt? discoveryMovie;

  const BrowserItem({Key? key, this.browser, this.discoveryMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _getImageProvider(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    8.0.w), // Padding to prevent text from touching edges
            child: Text(
              _getItemName(),
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0.r,
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              maxLines: 2, // Limits the text to one line
              overflow: TextOverflow
                  .ellipsis, // Truncates the text with an ellipsis if it overflows
              textAlign: TextAlign.center, // Align the text in the center
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _getImageProvider() {
    if (discoveryMovie?.posterPath != null) {
      return NetworkImage(
          'https://image.tmdb.org/t/p/w500${discoveryMovie!.posterPath}');
    }

    return AssetImage(_getDefaultImageForGenre());
  }

  String _getDefaultImageForGenre() {
    switch (browser?.name?.toLowerCase()) {
      case 'horror':
        return MyAssets.download4;
      case 'action':
        return MyAssets.download2;
      case 'animation':
        return MyAssets.download3;
      default:
        return MyAssets.download1;
    }
  }

  String _getItemName() {
    return discoveryMovie?.title ?? browser?.name ?? "Movie";
  }
}
