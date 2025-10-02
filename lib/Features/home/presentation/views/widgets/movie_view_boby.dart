import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service/init_getit.dart';
import '../../manger/movies/movies_bloc.dart';

import 'moview_list_view.dart';

class MovieViewBoby extends StatelessWidget {
  const MovieViewBoby({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoadingState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is MoviesErrorState) {
          return Center(child: Text(state.message));
        } else if (state is MoviesLoadedState ||
            state is MoviesLoadingMoreState) {
          final movies =
              state is MoviesLoadedState
                  ? state.movies
                  : (state as MoviesLoadingMoreState).movies;
          bool isLoadingMore = state is MoviesLoadingMoreState;
          int itemCount = isLoadingMore ? movies.length + 1 : movies.length;

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !isLoadingMore) {
                getIt<MoviesBloc>().add(FetchMoreMoviesEvent());
                return true;
              }
              return false;
            },
            child: MovieListView(
              itemCount: itemCount,
              movies: movies,
              isLoadingMore: isLoadingMore,
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
