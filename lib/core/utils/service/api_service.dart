import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../Features/home/data/models/movies_genre.dart';
import '../../../Features/home/data/models/movies_model.dart';
import '../../constants/api_constants.dart';
import 'helper/api.dart';

class ApiService {
  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    Map<String, dynamic> data = await Api().get(
      url: "${ApiConstants.baseUrl}/movie/popular?language=en-US&page=$page",
    );
    // List<MovieModel> movieList = [];
    // for (int i = 0; i < data.length; i++) {
    //   movieList.add(MovieModel.fromJson(data[i]));
    // }
    // log("=================================== $movieList");
    log("=================================== ${data.toString()} ");
    return List.from(
      data['results'].map((element) => MovieModel.fromJson(element)),
    );
    //   // log("data $data");
    //   // return List.from(
    //   //   data['results'].map((element) => MovieModel.fromJson(element)),
    //   // );
  }

  Future<List<MoviesGenre>> fetchGenres() async {
    // final url = Uri.parse(
    //   "${ApiConstants.baseUrl}/genre/movie/list?language=en",
    // );
    var data = await Api().get(
      url: "${ApiConstants.baseUrl}/genre/movie/list?language=en",
    );

    // log("data $data");
    return List.from(
      data['genres'].map((element) => MoviesGenre.fromJson(element)),
    );
  }
}

// class ApiService {
//   final _baseUrl = 'https://www.googleapis.com/books/v1/';
//   final Dio _dio;

//   ApiService(this._dio);

//   Future<Map<String, dynamic>> get({required String endPoint}) async {
//     Response response = await _dio.get('$_baseUrl$endPoint');
//     return response.data;
//   }
// }

// class ApiService {
//   Future<List<MovieModel>> fetchMovies({int page = 1}) async {
//     final url = Uri.parse(
//       "${ApiConstants.baseUrl}/movie/popular?language=en-US&page=$page",
//     );
//     final response = await http
//         .get(url, headers: ApiConstants.headers)
//         .timeout(const Duration(seconds: 10));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       log("=================================== ${response.statusCode}");
//       log("=================================== ${data.toString()} ");
//       // log("data $data");
//       return List.from(
//         data['results'].map((element) => MovieModel.fromJson(element)),
//       );
//     } else {
//       throw Exception("Failed to load movies: ${response.statusCode}");
//     }
//   }

//   Future<List<MoviesGenre>> fetchGenres() async {
//     final url = Uri.parse(
//       "${ApiConstants.baseUrl}/genre/movie/list?language=en",
//     );
//     final response = await http
//         .get(url, headers: ApiConstants.headers)
//         .timeout(const Duration(seconds: 10));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       // log("data $data");
//       return List.from(
//         data['genres'].map((element) => MoviesGenre.fromJson(element)),
//       );
//     } else {
//       throw Exception("Failed to load movies: ${response.statusCode}");
//     }
//   }
// }
