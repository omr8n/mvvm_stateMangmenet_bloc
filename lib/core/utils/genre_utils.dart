// import '../../Features/home/data/models/movies_genre.dart';
// import '../../Features/home/domain/repos/movies_repo.dart';
// import 'service/init_getit.dart';

// class GenreUtils {
//   static List<MoviesGenre> movieGenresNames(List<int> genreIds) {
//     final moviesRepository = getIt<MovieRepo>();
//     //  final cachedGenres = moviesRepository.cachedGenres;
//     List<MoviesGenre> genresNames = [];
//     for (int genreId in genreIds) {
//       MoviesGenre genre = genresNames.firstWhere(
//         (g) => g.id == genreId,
//         orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
//       );
//       genresNames.add(genre);
//     }
//     return genresNames;
//   }
// }

import '../../Features/home/data/models/movies_genre.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(
    List<int> movieGenreIds,
    List<MoviesGenre> allGenresList,
  ) {
    List<MoviesGenre> genresNames = [];
    for (var genreId in movieGenreIds) {
      var genre = allGenresList.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
