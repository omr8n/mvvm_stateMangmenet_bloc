import 'package:get_it/get_it.dart';

import 'package:mvvm_statemangments_cubit/Features/home/domain/repos/movies_repo.dart';
import 'package:mvvm_statemangments_cubit/Features/home/presentation/manger/favorites/favorites_bloc.dart';
import 'package:mvvm_statemangments_cubit/core/utils/service/helper/api.dart';

import '../../../Features/home/data/repos/movie_repo_impl.dart';
import '../../../Features/home/presentation/manger/movies/movies_bloc.dart';
import '../../theme/theme_bloc.dart';
import 'api_service.dart';
import 'navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<NavigationService>(NavigationService());
  // getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerSingleton<ApiService>(ApiService(Api()));
  getIt.registerSingleton<MovieRepoImpl>(MovieRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<MovieRepo>(
    () => MovieRepoImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<MoviesBloc>(() => MoviesBloc());
  getIt.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc());
}
