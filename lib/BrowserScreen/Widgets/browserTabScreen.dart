import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import '../../MovieDetails(homeTab)/movie_details_screen.dart';
import '../browserViewModel/browserTabStates.dart';
import '../browserViewModel/browserTabViewModel.dart';
import '../dataBrowser/responseBrowser/browserDiscoveryRespone.dart';
import '../dataBrowser/responseBrowser/browserResponse.dart';
import 'BrowserItem.dart';

class BrowserTabScreen extends StatefulWidget {
  static const String routeName = 'browser'; // Add route name if required

  const BrowserTabScreen({Key? key}) : super(key: key);

  @override
  State<BrowserTabScreen> createState() => _BrowserTabScreenState();
}

class _BrowserTabScreenState extends State<BrowserTabScreen> {
  late final BrowserTabViewModel viewModel;
  String? selectedGenreId; // Add this variable to track selected genre ID
  List<dynamic> discoveryMovies = []; // To store the discovery movie results

  @override
  void initState() {
    super.initState();
    viewModel = BrowserTabViewModel();
    viewModel.getAllMovieList(); // Fetch all movie lists
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
                  } else if (state is BrowserDiscoveryTabSuccessState ||
                      discoveryMovies.isNotEmpty) {
                    if (state is BrowserDiscoveryTabSuccessState) {
                      discoveryMovies =
                          state.browserDiscoveryResponse.results ?? [];
                    }
                    return _buildMovieGrid(
                        genres: discoveryMovies, isDiscovery: true);
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

                if (selectedGenreId != genreId) {
                  // Check if genre has changed
                  setState(() {
                    selectedGenreId = genreId; // Update selected genre ID
                    discoveryMovies.clear(); // Clear previous results
                  });

                  viewModel
                      .getAllDiscoveryMovieList(genreId); // Fetch new movies

                  DefaultTabController.of(context)
                      ?.animateTo(1); // Switch to Discovery Tab
                }
              } else {
                // Navigate to the MovieDetailsScreen when a movie is tapped
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                            movieId: discoveryMovies[index].id!.toInt())));
              }
            },
            child: BrowserItem(
              browser: !isDiscovery
                  ? item as Browser
                  : null, // Ensure proper casting
              discoveryMovie: isDiscovery ? item as reselt : null, // Fixed typo
            ),
          );
        },
      ),
    );
  }
}
