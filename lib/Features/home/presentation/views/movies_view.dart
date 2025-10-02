// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:mvvm_statemangments/Features/home/presentation/views/favorite_view.dart';
// import 'package:mvvm_statemangments/core/constants/my_app_constants.dart';
// import 'package:mvvm_statemangments/core/utils/service/api_service.dart';

// import '../../../../core/constants/my_app_icons.dart';

// import '../../../../core/utils/service/init_getit.dart';
// import '../../../../core/utils/service/navigation_service.dart';

// import '../../data/models/movies_genre.dart';
// import '../../data/models/movies_model.dart';
// import '../../domain/repos/movies_repo.dart';
// import 'widgets/movies_item.dart';

// class MoviesView extends StatefulWidget {
//   const MoviesView({super.key});

//   @override
//   State<MoviesView> createState() => _MoviesViewState();
// }

// class _MoviesViewState extends State<MoviesView> {
//   int _currentPage = 1;
//   bool _isFetching = false;
//   ScrollController get _scrollController => ScrollController();
//   final List<MovieModel> _movies = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchMovies();
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent &&
//         !_isFetching) {
//       _fetchMovies();
//     }
//   }

//   Future<void> _fetchMovies() async {
//     if (_isFetching) return;
//     setState(() {
//       _isFetching = true;
//     });
//     try {
//       final List<MovieModel> movie = await getIt<MovieRepo>().fetchMovies(
//         page: _currentPage,
//       );
//       setState(() {
//         _movies.addAll(movie);
//         _currentPage++;
//       });
//     } catch (error) {
//       getIt<NavigationService>().showSnackbar(
//         "An Error has been occured $error",
//       );
//     } finally {
//       setState(() {
//         _isFetching = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Popular Movies"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // getIt<NavigationService>().showSnackbar("hellooooooooo");

//               getIt<NavigationService>().showDialog(FavoritesView());
//               // getIt<NavigationService>().navigate(FavoriteView());
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Scaffold()),
//               // );
//             },
//             icon: const Icon(MyAppIcons.favoriteRounded, color: Colors.red),
//           ),
//           IconButton(
//             onPressed: () async {
//               // final List<MovieModel> movies =
//               //     await getIt<ApiService>().fetchMovies();
//               // log("movies= $movies");
//               final List<MoviesGenre> genres =
//                   //   await getIt<HomeRepo>().fetchGenres();
//                   await getIt<ApiService>().fetchGenres();

//               log(
//                 "Genres are============================================ $genres",
//               );
//             },
//             icon: const Icon(MyAppIcons.darkMode),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: _movies.length + (_isFetching ? 1 : 0),

//         itemBuilder: (context, index) {
//           // return CachedImageWidget(
//           //   imgUrl: MyAppConstants.movieImage1,
//           //   boxFit: BoxFit.fill,
//           //   imgHeight: 400,
//           // );
//           if (index < _movies.length) {
//             return MoviesItem(movieModel: MyAppConstants.movies[index]);
//           } else {
//             return const CircularProgressIndicator.adaptive();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemangments_cubit/Features/home/presentation/views/widgets/movie_view_boby.dart';

import '../../../../core/constants/my_app_icons.dart';

import '../../../../core/theme/theme_bloc.dart';

import '../../../../core/utils/service/init_getit.dart';
import '../../../../core/utils/service/navigation_service.dart';

import 'favorite_view.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesView());
            },
            icon: const Icon(MyAppIcons.favoriteRounded, color: Colors.red),
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  // context.read<ThemeBloc>().add(ToggleThemeEvent());
                  getIt<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: Icon(
                  state is DarkThemeState
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
              );
            },
          ),
        ],
      ),
      body: MovieViewBoby(),
    );
  }
}
