import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_constants.dart';

class Api {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = ApiConstants.headers;

    //
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    //
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'there is a problem with status code ${response.statusCode}',
      );
    }
  }

  Future<dynamic> post({
    required String url,
    @required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(
        'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> put({
    required String url,
    @required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    // headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    log('url = $url body = $body token = $token ');
    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      log('data = $data');
      return data;
    } else {
      throw Exception(
        'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }
}
