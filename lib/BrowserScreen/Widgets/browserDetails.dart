import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import '../dataBrowser/responseBrowser/browserDiscoveryRespone.dart'; // Ensure the correct import for your data model

class BrowserDetails extends StatefulWidget {
  static const String routeName = 'browserDetails'; // Fixed route name typo

  @override
  _BrowserDetailsState createState() => _BrowserDetailsState();
}

class _BrowserDetailsState extends State<BrowserDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Use the correct class name for the argument passed
    var args = ModalRoute.of(context)?.settings.arguments
        as reselt; // Corrected the type to `Result`

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: 20.h,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    args.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500${args.posterPath}'
                        : 'https://via.placeholder.com/500x250?text=No+Image',
                    width: double.infinity,
                    height: 250.h,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Image failed to load'));
                    },
                  ),
                  Positioned(
                    left: 176.w,
                    bottom: 78.h,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow, size: 30),
                        onPressed: () {
                          // Action for play button
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args.title ?? "No Title Available",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      args.releaseDate ?? "No release date",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            args.posterPath != null
                                ? 'https://image.tmdb.org/t/p/w500${args.posterPath}'
                                : 'https://via.placeholder.com/100x150?text=No+Image',
                            width: 129.w,
                            height: 220.h,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Image failed to load'));
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.h),
                              SizedBox(height: 10.h),
                              Text(
                                args.overview ?? "No description available",
                                maxLines: isExpanded ? null : 2,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 14.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "show less" : "show more",
                                  style: TextStyle(
                                    color: AppColors.whiteColorText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  SizedBox(width: 5.w),
                                  Text(
                                    args.voteAverage?.toString() ?? "No Rating",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Divider(color: Colors.grey.shade800),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
