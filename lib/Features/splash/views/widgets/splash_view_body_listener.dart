import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service/init_getit.dart';
import '../../../../core/utils/service/navigation_service.dart';
import '../../../../core/widgets/my_error_widget.dart';
import '../../../home/presentation/manger/favorites/favorites_bloc.dart';
import '../../../home/presentation/manger/movies/movies_bloc.dart';
import '../../../home/presentation/views/movies_view.dart';
import 'splash_view_body.dart';

// class SplashViewBodyListener extends StatelessWidget {
//   const SplashViewBodyListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final moviesBloc = getIt<MoviesBloc>();
//     final favoriteBloc = getIt<FavoritesBloc>();
//     final navigationService = getIt<NavigationService>();
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<MoviesBloc, MoviesState>(
//           bloc: moviesBloc..add(FetchMoviesEvent()),
//           listener: (context, state) {
//             if (state is MoviesLoadedState &&
//                 favoriteBloc.state is FavoritesLoaded) {
//               navigationService.navigateReplace(const MoviesView());
//             } else if (state is MoviesErrorState) {
//               navigationService.showSnackbar(state.message);
//             }
//           },
//         ),
//         BlocListener<FavoritesBloc, FavoritesState>(
//           bloc: favoriteBloc..add(LoadFavorites()),
//           listener: (context, state) {
//             if (state is FavoritesError) {
//               navigationService.showSnackbar(state.message);
//             }
//           },
//         ),
//       ],
//       child: BlocBuilder<MoviesBloc, MoviesState>(
//         bloc: moviesBloc..add(FetchMoviesEvent()),
//         builder: (context, state) {
//           if (state is MoviesLoadingState) {
//             return SplashViewBody();
//           } else if (state is MoviesErrorState) {
//             return MyErrorWidget(
//               errorText: state.message,
//               onPressed: () {
//                 moviesBloc.add(FetchMoviesEvent());
//               },
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }

class SplashViewBodyListener extends StatelessWidget {
  const SplashViewBodyListener({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = getIt<MoviesBloc>();
    final favoriteBloc = getIt<FavoritesBloc>();
    final navigationService = getIt<NavigationService>();

    moviesBloc.add(FetchMoviesEvent());
    favoriteBloc.add(LoadFavorites());

    return MultiBlocListener(
      listeners: [
        BlocListener<MoviesBloc, MoviesState>(
          bloc: moviesBloc,
          listener: (context, state) {
            if (state is MoviesErrorState) {
              navigationService.showSnackbar(state.message);
              showAdaptiveAboutDialog(context: context);
            }
          },
        ),
        BlocListener<FavoritesBloc, FavoritesState>(
          bloc: favoriteBloc,
          listener: (context, state) {
            if (state is FavoritesError) {
              navigationService.showSnackbar(state.message);
              // showAdaptiveAboutDialog(context: context);
            }
          },
        ),
      ],
      child: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: moviesBloc,
        builder: (context, moviesState) {
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            bloc: favoriteBloc,
            builder: (context, favoritesState) {
              if (moviesState is MoviesLoadingState ||
                  favoritesState is FavoritesInitial) {
                return const SplashViewBody();
              } else if (moviesState is MoviesErrorState) {
                return MyErrorWidget(
                  errorText: moviesState.message,
                  onPressed: () {
                    moviesBloc.add(FetchMoviesEvent());
                  },
                );
              } else if (moviesState is MoviesLoadedState &&
                  favoritesState is FavoritesSuccess) {
                // تأخير قصير للسماح بإعادة البناء قبل التنقل
                Future.microtask(
                  () => navigationService.navigateReplace(const MoviesView()),
                );
                return const SizedBox.shrink(child: Text("fewfwf"));
              }
              return const SizedBox.shrink(
                child: Center(child: Text("qaaaaaaaaaa")),
              );
            },
          );
        },
      ),
    );
  }
}
