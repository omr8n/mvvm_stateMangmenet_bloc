import 'package:flutter/material.dart';

import '../../../data/models/movies_model.dart';
import 'movies_item.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
    required this.itemCount,
    required this.movies,
    required this.isLoadingMore,
  });

  final int itemCount;
  final List<MovieModel> movies;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= movies.length && isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return MoviesItem(movieModel: movies[index]);
      },
    );
  }
}
