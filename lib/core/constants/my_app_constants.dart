import '../../Features/home/data/models/movies_model.dart';

class MyAppConstants {
  static const String movieImage = "https://i.ibb.co/FwTPCCc/Ultra-Linx.jpg";
  static const String movieImage1 =
      "https://upload.wikimedia.org/wikipedia/commons/e/e1/FullMoon2010.jpg";

  static const List<String> genres = ["Horror", "Action", "Thriller", "Drama"];

  static List<MovieModel> movies = [
    MovieModel(
        adult: true,
        backdropPath: "fef",
        genreIds: [1, 2, 3],
        id: 3,
        originalLanguage: "efe",
        originalTitle: "efef",
        overview: "fef",
        popularity: 32,
        posterPath: "fewsf",
        releaseDate: "Efwef",
        title: "Fewf",
        video: false,
        voteAverage: 343,
        voteCount: 32),
    MovieModel(
        adult: true,
        backdropPath: "fef",
        genreIds: [3232, 43342, 3444],
        id: 3,
        originalLanguage: "efe",
        originalTitle: "efef",
        overview: "fef",
        popularity: 32,
        posterPath: "fewsf",
        releaseDate: "Efwef",
        title: "Fewf",
        video: false,
        voteAverage: 343,
        voteCount: 32),
  ];
}
