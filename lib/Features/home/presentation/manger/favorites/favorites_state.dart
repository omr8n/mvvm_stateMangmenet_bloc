part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesSuccess extends FavoritesState {
  final List<MovieModel> favorites;

  const FavoritesSuccess({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});
  @override
  List<Object> get props => [message];
}
