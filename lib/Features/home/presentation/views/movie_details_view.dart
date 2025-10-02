import 'package:flutter/material.dart';

import '../../../../core/constants/my_app_constants.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../data/models/movies_model.dart';
import 'widgets/favorite_btn.dart';
import 'widgets/genres_list_view.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key, required this.movieModel});

  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: movieModel.id,
              child: SizedBox(
                height: size.height * 0.45,
                width: double.infinity,
                child: CachedImageWidget(
                  imgUrl:
                      "https://image.tmdb.org/t/p/w500/${movieModel.backdropPath}",
                  // imgUrl: MyAppConstants.movieImage1,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    // child: Container(color: Colors.red,),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  movieModel.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    // color: Theme.of(context).textSelectionColor,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${movieModel.voteAverage.toStringAsFixed(1)}/10",
                                    ),
                                    const Spacer(),
                                    Text(
                                      movieModel.releaseDate,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                GenresListView(
                                  movieModel: movieModel,
                                  //    movieModel: movieModel,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  movieModel.overview,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FavoriteBtn(movieModel: movieModel),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
