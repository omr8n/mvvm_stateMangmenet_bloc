import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service/init_getit.dart';
import '../../../../../core/widgets/my_error_widget.dart';
import '../../manger/favorites/favorites_bloc.dart';
import 'movies_item.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is FavoritesError) {
          return MyErrorWidget(
            errorText: state.message,
            onPressed: () {
              getIt<FavoritesBloc>().add(LoadFavorites());
            },
          );
        } else if (state is FavoritesSuccess) {
          if (state.favorites.isEmpty) {
            return const Center(
              child: Text(
                "No Favorites has been added yet",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return MoviesItem(movieModel: state.favorites[index]); //
            },
          );
        }
        // ignore: curly_braces_in_flow_control_structures
        return const SizedBox.shrink();
      },
    );
  }
}
