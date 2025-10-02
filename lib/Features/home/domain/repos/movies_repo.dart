import '../../data/models/movies_genre.dart';
import '../../data/models/movies_model.dart';

abstract class MovieRepo {
  MovieRepo();

  Future<List<MovieModel>> fetchMovies({int page = 1});

  Future<List<MoviesGenre>> fetchGenres();
}
