// import 'package:flutter/material.dart';

// import '../../../../../core/constants/my_app_icons.dart';
// import '../../../data/models/movies_model.dart';

// class FavoriteBtnWidget extends StatefulWidget {
//   const FavoriteBtnWidget({super.key, required this.movieModel});
//   final MovieModel movieModel;

//   @override
//   State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
// }

// class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
//   final favoriteMovieIds = [];
//   @override
//   Widget build(BuildContext context) {
//     bool isFavorite = favoriteMovieIds.contains(widget.movieModel.id);
//     return IconButton(
//       onPressed: () {
//         if (isFavorite) {
//           favoriteMovieIds.remove(widget.movieModel.id);
//         } else {
//           favoriteMovieIds.add(widget.movieModel.id);
//         }
//         setState(() {});
//       },
//       icon: Icon(
//         //  MyAppIcons.favoriteOutlineRounded,
//         isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
//         color: isFavorite ? Colors.red : null,
//         size: 20,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemangments_cubit/Features/home/data/models/movies_model.dart';

import '../../../../../core/constants/my_app_icons.dart';
import '../../../../../core/utils/service/init_getit.dart';
import '../../../../../core/utils/service/navigation_service.dart';
import '../../manger/favorites/favorites_bloc.dart';

class FavoriteBtn extends StatelessWidget {
  const FavoriteBtn({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    final navigationService = getIt<NavigationService>();
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if ((state is FavoritesError)) {
          navigationService.showSnackbar(
            "An error has been occured ${state.message}",
          );
        }
      },
      builder: (context, state) {
        bool isFavorite =
            (state is FavoritesSuccess) &&
            state.favorites.any((movie) => movie.id == movieModel.id);
        return IconButton(
          onPressed: () {
            getIt<FavoritesBloc>().add(
              isFavorite
                  ? RemoveFromFavorites(movieModel: movieModel)
                  : AddToFavorites(movieModel: movieModel),
            );
            // if (isFavorite) {
            //   getIt<FavoritesBloc>().add(
            //     RemoveFromFavorites(movieModel: movieModel),
            //   );
            // } else {
            //   getIt<FavoritesBloc>().add(
            //     AddToFavorites(movieModel: movieModel),
            //   );
            // }
          },
          icon: Icon(
            isFavorite
                ? MyAppIcons.favorite
                : MyAppIcons.favoriteOutlineRounded,
            color: isFavorite ? Colors.red : null,
            size: 20,
          ),
        );
      },
    );
  }
}

// class FavoriteBtn extends StatelessWidget {
//   const FavoriteBtn({super.key, required this.movieModel});
//   final MovieModel movieModel;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoritesBloc, FavoritesState>(
//       builder: (context, state) {
//         bool isFavorite =
//             (state is FavoritesLoaded) &&
//             state.favorites.any((movie) => movie.id == movieModel.id);
//         return IconButton(
//           onPressed: () {
//             getIt<FavoritesBloc>().add(
//               isFavorite
//                   ? RemoveFromFavorites(movieModel: movieModel)
//                   : AddToFavorites(movieModel: movieModel),
//             );
//             // if (isFavorite) {
//             //   getIt<FavoritesBloc>()
//             //       .add(RemoveFromFavorites(movieModel: movieModel));
//             // } else {
//             //   getIt<FavoritesBloc>()
//             //       .add(AddToFavorites(movieModel: movieModel));
//             // }
//           },
//           icon: Icon(
//             isFavorite
//                 ? MyAppIcons.favorite
//                 : MyAppIcons.favoriteOutlineRounded,
//             color: isFavorite ? Colors.red : null,
//             size: 20,
//           ),
//         );
//       },
//     );
//   }
// }
