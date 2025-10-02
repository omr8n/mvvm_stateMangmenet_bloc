// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as apiService;

import '../../../../core/utils/service/api_service.dart';

import '../../domain/repos/movies_repo.dart';
import '../models/movies_genre.dart';
import '../models/movies_model.dart';

class MovieRepoImpl extends MovieRepo {
  final ApiService _apiService;
  MovieRepoImpl(this._apiService);

  @override
  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  // @override
  // Future<List<MovieModel>> fetchMovies({int page = 1}) async {
  //   return await _apiService.fetchMovies(page: page);
  // }

  //List<MoviesGenre> cachedGenres = [];
  @override
  Future<List<MoviesGenre>> fetchGenres() async {
    return await _apiService.fetchGenres();
  }
}
