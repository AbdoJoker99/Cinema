import 'package:cinema/AppColors.dart';
import 'package:cinema/BrowserScreen/browserViewModel/browserTabStates.dart';
import 'package:cinema/BrowserScreen/browserViewModel/browserTabViewModel.dart';
import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserDiscoveryRespone.dart';
import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserResponse.dart';
import 'package:cinema/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Browseritem.dart';

class BrowserTabScreen extends StatefulWidget {
  static const String routeName = "browser";

  const BrowserTabScreen({Key? key}) : super(key: key);

  @override
  State<BrowserTabScreen> createState() => _BrowserTabScreenState();
}

class _BrowserTabScreenState extends State<BrowserTabScreen> {
  late final BrowserTabViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = BrowserTabViewModel();
    viewModel.getAllMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            toolbarHeight: 50,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Genres'),
                Tab(text: 'Discovery'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Genres Tab
              BlocBuilder<BrowserTabViewModel, BrowserTabStates>(
                builder: (context, state) {
                  if (state is BrowserTabLoadinglState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BrowserTabErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 18.sp),
                      ),
                    );
                  } else if (state is BrowserTabSuccessState) {
                    var genres = state.browserResponse.genres ?? [];
                    return _buildMovieGrid(genres: genres, isDiscovery: false);
                  }

                  var cachedGenres = viewModel.cachedGenres;
                  if (cachedGenres != null && cachedGenres.isNotEmpty) {
                    return _buildMovieGrid(
                        genres: cachedGenres, isDiscovery: false);
                  }

                  return const Center(child: SizedBox());
                },
              ),
              // Discovery Tab
              BlocBuilder<BrowserTabViewModel, BrowserTabStates>(
                builder: (context, state) {
                  if (state is BrowserDiscoveryTabLoadinglState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BrowserDiscoveryTabErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 18.sp),
                      ),
                    );
                  } else if (state is BrowserDiscoveryTabSuccessState) {
                    var discoveryMovies =
                        state.browserDiscoveryResponse.results ?? [];
                    return Column(
                      children: [
                        Expanded(
                            child: _buildMovieGrid(
                                genres: discoveryMovies, isDiscovery: true)),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                            child: Text('Go to Home'))
                      ],
                    );
                  }
                  return const Center(child: Text('No Data Available'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(
      {required List<dynamic> genres, required bool isDiscovery}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GridView.builder(
        itemCount: genres.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final item = genres[index];
          return InkWell(
            onTap: () {
              if (!isDiscovery) {
                String genreId = item.id.toString();
                viewModel.getAllDiscoveryMovieList(genreId);

                DefaultTabController.of(context).animateTo(1);
              }
            },
            child: BrowserItem(
              browser: isDiscovery ? null : item as Browser,
              discoveryMovie: isDiscovery ? item as reselt : null,
            ),
          );
        },
      ),
    );
  }
}
