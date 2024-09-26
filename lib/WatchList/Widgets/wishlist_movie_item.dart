import 'package:cinema/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:flutter/material.dart';

import '../../AppColors.dart';
import '../../HomeTab/Data/apiManger.dart';
import '../../HomeTab/Data/endPoint.dart';
import '../../firebase_utils.dart';

class WatchlistMovieItem extends StatelessWidget {
  final topRatedOrPopular model;

  const WatchlistMovieItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 90,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${EndPoints.imageBaseURL}${model.posterPath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Firestore.removeMovieByTitle(model.title ?? '');
                    },
                    child: Image.asset(
                      (model.isFavorite!)
                          ? 'assets/images/Icon awesome-bookmark.png'
                          : 'assets/images/bookmark.png',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: AppColors.whiteColorText,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Year: ${ApiManager.getMovieReleaseYear(model.releaseDate ?? '')}',
                        style: const TextStyle(color: AppColors.whiteColorText),
                      ),
                      Row(
                        children: [
                          const ImageIcon(
                            AssetImage("assets/images/star_rate.png"),
                            color: AppColors.yellow,
                          ),
                          Text(
                            "${model.voteAverage}",
                            style: const TextStyle(
                                color: AppColors.whiteColorText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: const Divider(
            height: 2,
            color: AppColors.greySearchBarColor,
          ),
        ),
      ],
    );
  }
}
