import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Crud {
  final Dio _dio = Dio();

  Future get({
    required final String url,
  }) async {
    try {
      // Setting up Dio options
      _dio.options.headers['content-Type'] = 'application/json';

      //  _dio.options.headers["Authorization"] =
      //   "Bearer 11241|PC4DhW5BQNqSebpT2QjRJhA8pBSMlkN76cIPQpMU0a88d161";
      //add token from shared Pref

      final prefs = await SharedPreferences.getInstance();
      final token = prefs
          .getString('access_token'); // Retrieve token from shared preferences
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Performing GET request
      Response response = await _dio.get(url);

      dynamic jsonResponse = response.data;

      return jsonResponse;
    } catch (e) {
      get(url: url);
    }
  }
}
