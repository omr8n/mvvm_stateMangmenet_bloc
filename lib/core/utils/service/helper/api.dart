// // import 'dart:convert';
// // import 'dart:developer';

// // import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart' as http;

// // import '../../../constants/api_constants.dart';

// // class Api {
// //   Future<dynamic> get({required String url, String? token}) async {
// //     Map<String, String> headers = ApiConstants.headers;

// //     //
// //     http.Response response = await http.get(Uri.parse(url), headers: headers);
// //     //
// //     if (response.statusCode == 200) {
// //       return jsonDecode(response.body);
// //     } else {
// //       throw Exception(
// //         'there is a problem with status code ${response.statusCode}',
// //       );
// //     }
// //   }

// //   Future<dynamic> post({
// //     required String url,
// //     @required dynamic body,
// //     String? token,
// //   }) async {
// //     Map<String, String> headers = {};

// //     if (token != null) {
// //       headers.addAll({'Authorization': 'Bearer $token'});
// //     }
// //     http.Response response = await http.post(
// //       Uri.parse(url),
// //       body: body,
// //       headers: headers,
// //     );
// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = jsonDecode(response.body);

// //       return data;
// //     } else {
// //       throw Exception(
// //         'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}',
// //       );
// //     }
// //   }

// //   Future<dynamic> put({
// //     required String url,
// //     @required dynamic body,
// //     String? token,
// //   }) async {
// //     Map<String, String> headers = {
// //       'Content-Type': 'application/x-www-form-urlencoded',
// //     };
// //     // headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
// //     if (token != null) {
// //       headers.addAll({'Authorization': 'Bearer $token'});
// //     }

// //     log('url = $url body = $body token = $token ');
// //     http.Response response = await http.put(
// //       Uri.parse(url),
// //       body: body,
// //       headers: headers,
// //     );
// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = jsonDecode(response.body);
// //       log('data = $data');
// //       return data;
// //     } else {
// //       throw Exception(
// //         'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}',
// //       );
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Api {
//   final http.Client _client = http.Client();

//   String? _accessToken;
//   String? _refreshToken;

//   Api();

//   /// تحميل التوكن من SharedPreferences
//   Future<void> initTokens() async {
//     final prefs = await SharedPreferences.getInstance();
//     _accessToken = prefs.getString("accessToken");
//     _refreshToken = prefs.getString("refreshToken");
//   }

//   Map<String, String> _buildHeaders({bool isJson = true}) {
//     final headers = <String, String>{};
//     if (isJson) headers['Content-Type'] = 'application/json';
//     if (_accessToken != null) {
//       headers['Authorization'] = 'Bearer $_accessToken';
//     }
//     return headers;
//   }

//   Future<dynamic> get({required String url}) async {
//     return _sendRequest(
//       () => _client.get(Uri.parse(url), headers: _buildHeaders()),
//     );
//   }

//   Future<dynamic> post({required String url, required dynamic body}) async {
//     return _sendRequest(
//       () => _client.post(
//         Uri.parse(url),
//         body: jsonEncode(body),
//         headers: _buildHeaders(),
//       ),
//     );
//   }

//   Future<dynamic> put({required String url, required dynamic body}) async {
//     return _sendRequest(
//       () => _client.put(
//         Uri.parse(url),
//         body: jsonEncode(body),
//         headers: _buildHeaders(),
//       ),
//     );
//   }

//   Future<dynamic> _sendRequest(
//     Future<http.Response> Function() requestFunc,
//   ) async {
//     try {
//       final response = await requestFunc();

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       }

//       // إذا انتهت صلاحية التوكن
//       if (response.statusCode == 401 && _refreshToken != null) {
//         final renewed = await _refreshAccessToken();
//         if (renewed) {
//           // إعادة الطلب بالتوكن الجديد
//           final retryResponse = await requestFunc();
//           if (retryResponse.statusCode == 200) {
//             return jsonDecode(retryResponse.body);
//           }
//         }
//       }

//       throw Exception('Error ${response.statusCode}: ${response.body}');
//     } catch (e) {
//       log('Request error: $e');
//       rethrow;
//     }
//   }

//   Future<bool> _refreshAccessToken() async {
//     try {
//       if (_refreshToken == null) {
//         log("Refresh token is null");
//         return false;
//       }

//       final url = "https://yourapi.com/refresh"; // عدّل للرابط الصحيح
//       log("Refreshing token at: $url with refreshToken=$_refreshToken");

//       final response = await _client.post(
//         Uri.parse(url),
//         body: jsonEncode({"refresh_token": _refreshToken}),
//         headers: {"Content-Type": "application/json"},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         _accessToken = data["accessToken"];
//         _refreshToken = data["refreshToken"] ?? _refreshToken;

//         // حفظ التوكنات في SharedPreferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString("accessToken", _accessToken!);
//         await prefs.setString("refreshToken", _refreshToken!);

//         log("Tokens refreshed successfully");
//         return true;
//       } else {
//         log(
//           "Refresh token failed with status ${response.statusCode} and body ${response.body}",
//         );
//       }
//       return false;
//     } catch (e) {
//       log("Refresh token error: $e");
//       return false;
//     }
//   }

//   void close() {
//     _client.close();
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final http.Client _client = http.Client();

  String? _accessToken;
  String? _refreshToken;

  Api();

  /// تحميل التوكن من SharedPreferences
  Future<void> initTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString("accessToken");
    _refreshToken = prefs.getString("refreshToken");
    log("Tokens loaded: accessToken=$_accessToken refreshToken=$_refreshToken");
  }

  Map<String, String> _buildHeaders({bool isJson = true}) {
    final headers = <String, String>{};
    if (isJson) headers['Content-Type'] = 'application/json';
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  Future<dynamic> get({required String url}) async {
    return _sendRequest(
      () => _client.get(Uri.parse(url), headers: _buildHeaders()),
    );
  }

  Future<dynamic> post({required String url, required dynamic body}) async {
    return _sendRequest(
      () => _client.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: _buildHeaders(),
      ),
    );
  }

  Future<dynamic> put({required String url, required dynamic body}) async {
    return _sendRequest(
      () => _client.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: _buildHeaders(),
      ),
    );
  }

  Future<dynamic> _sendRequest(
    Future<http.Response> Function() requestFunc,
  ) async {
    try {
      final response = await requestFunc();

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      if (response.statusCode == 401 && _refreshToken != null) {
        log("401 Unauthorized — Attempting token refresh");
        final renewed = await _refreshAccessToken();
        if (renewed) {
          final retryResponse = await requestFunc();
          if (retryResponse.statusCode == 200) {
            return jsonDecode(retryResponse.body);
          }
        }
      }

      throw Exception('Error ${response.statusCode}: ${response.body}');
    } catch (e) {
      log('Request error: $e');
      rethrow;
    }
  }

  Future<bool> _refreshAccessToken() async {
    try {
      if (_refreshToken == null) {
        log("Refresh token is null");
        return false;
      }

      final url = "https://yourapi.com/refresh"; // عدّل للرابط الصحيح
      log("Refreshing token at: $url with refreshToken=$_refreshToken");

      final response = await _client.post(
        Uri.parse(url),
        body: jsonEncode({"refresh_token": _refreshToken}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        _accessToken = data["accessToken"];
        _refreshToken = data["refreshToken"] ?? _refreshToken;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("accessToken", _accessToken!);
        await prefs.setString("refreshToken", _refreshToken!);

        log("Tokens refreshed successfully");
        return true;
      } else {
        log("Refresh token failed: ${response.statusCode}");
      }
      return false;
    } catch (e) {
      log("Refresh token error: $e");
      return false;
    }
  }

  void close() {
    _client.close();
  }
}
