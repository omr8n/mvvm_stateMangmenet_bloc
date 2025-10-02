import 'package:flutter/material.dart';

import '../../../../core/constants/my_app_icons.dart';
import '../../../../core/utils/service/init_getit.dart';

import '../manger/favorites/favorites_bloc.dart';
import 'widgets/favorites_view_body.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              getIt<FavoritesBloc>().add(RemoveAllFromFavorites());
            },
            icon: const Icon(MyAppIcons.delete, color: Colors.red),
          ),
        ],
      ),
      body: FavoritesViewBody(),
    );
  }
}
