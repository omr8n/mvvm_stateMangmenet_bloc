import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/service/helper/shared_preferences_singleton.dart';
import '../../../data/models/movies_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_loadFavorites);
    on<AddToFavorites>(_addToFavorites);
    on<RemoveFromFavorites>(_removeFromFavorites);
    on<RemoveAllFromFavorites>(_clearAllFavs);

    // تحميل المفضلات تلقائياً عند إنشاء الـ Bloc
    add(LoadFavorites());
  }

  final String favskey = "favsKey";

  Future<void> _saveFavorites(List<MovieModel> favoritesList) async {
    final stringList =
        favoritesList.map((movie) => json.encode(movie.toJson())).toList();
    await Prefs.setStringList(favskey, stringList);
  }

  bool _isFavorite(MovieModel movieModel, List<MovieModel> currentList) {
    return currentList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> _addToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final List<MovieModel> movieList =
        state is FavoritesSuccess
            ? List<MovieModel>.from((state as FavoritesSuccess).favorites)
            : [];

    if (_isFavorite(event.movieModel, movieList)) {
      log("Movie already in favorites");
      return;
    }

    movieList.add(event.movieModel);
    await _saveFavorites(movieList);
    emit(FavoritesSuccess(favorites: movieList));
  }

  Future<void> _removeFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesSuccess) return;

    final movieList = List<MovieModel>.from(
      (state as FavoritesSuccess).favorites,
    )..removeWhere((movie) => movie.id == event.movieModel.id);

    await _saveFavorites(movieList);
    emit(FavoritesSuccess(favorites: movieList));
  }

  Future<void> _loadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final stringList = Prefs.getStringList(favskey) ?? [];

      final List<MovieModel> favsList =
          stringList
              .map<MovieModel>(
                (movie) => MovieModel.fromJson(json.decode(movie)),
              )
              .toList();

      emit(FavoritesSuccess(favorites: favsList));
    } catch (e) {
      log("Error loading favorites: $e");
      emit(FavoritesError(message: "Failed to load favorites"));
    }
  }

  Future<void> _clearAllFavs(
    RemoveAllFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    await _saveFavorites([]);
    emit(const FavoritesSuccess(favorites: []));
  }
}
