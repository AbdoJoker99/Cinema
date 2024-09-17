import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import '../HomeTabViewModel/homeTabStates.dart';
import '../HomeTabViewModel/homeTabViewModel.dart';
import 'TopRatedSection.dart';
import 'UpComingSection.dart';
import 'movieCard.dart';

class Hometab extends StatefulWidget {
  static const String routeName = "homeTab";
  const Hometab({Key? key}) : super(key: key);

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  Hometabviewmodel viewModel = Hometabviewmodel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Hometabviewmodel, homeTabStates>(
        bloc: viewModel
          ..getAllTopRated()
          ..getAllPopular()
          ..getAllUpComing(),
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: AppColors.blackColor,
            appBar: AppBar(
              backgroundColor: AppColors.blackColor,
              toolbarHeight: 5.h, // Reduced toolbar height
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Popular Section
                    viewModel.popularList == null ||
                            viewModel.popularList!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors
                                  .whiteColorText, // Change color for visibility
                            ),
                          )
                        : MovieCard(moviecard: viewModel.popularList!.first),
                    SizedBox(height: 10.h),
                    // Upcoming Section
                    viewModel.upComingList == null ||
                            viewModel.upComingList!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColorText,
                            ),
                          )
                        : upComingSection(
                            name: 'New Releases',
                            upComingList: viewModel.upComingList!,
                          ),
                    SizedBox(height: 10.h),
                    // Top Rated Section
                    viewModel.topRatedList == null ||
                            viewModel.topRatedList!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColorText,
                            ),
                          )
                        : TopRatedSection(
                            name: 'Recommended',
                            topRatedList: viewModel.topRatedList!,
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
