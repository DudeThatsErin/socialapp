import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  // Method to validate JWT token
  Future<bool> validateToken(String jwt) async {
    try {
      Response response = await _dio.get(
        'https://buildexpo.us/wp-json/api/v1/token-validate',
        data: {'Authorization': jwt},
      );
      dynamic responseData = response.data;
      // Check if token is valid
      return responseData['success'] == true;
    } on DioException catch (e) {
      // Handle validation error
      print('Token validation error: $e');
      return false;
    }
  }

  // Method to refresh JWT token - emailed to ask how to do that.
  Future<String?> refreshToken(String jwt) async {
    try {
      Response response = await _dio.post(
        'https://buildexpo.us/?rest_route=/simple-jwt-login/v1/auth/refresh',
        data: {'JWT': jwt},
      );
      dynamic responseData = response.data;
      // Check if refresh was successful and return new token
      if (responseData['success'] == true && responseData['data'] != null) {
        return responseData['data']['jwt'];
      } else {
        // Refresh failed or response data is missing
        return null;
      }
    } on DioException catch (e) {
      // Handle refresh error
      print('Token refresh error: $e');
      return null;
    }
  }

  Future<Response<dynamic>> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'https://buildexpo.us/wp-json/api/v1/token',
        data: {'username': username, 'password': password},
      );

      print('response: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Successful login, return response
        return response;
      } else {
        // Throw an exception for unexpected status code
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: response,
        );
      }
    } on DioException catch (e) {
      // Handle DioError
      if (e.response != null) {
        // Handle error response from server
        print('Error response: ${e.response!.data}');
        return e.response!;
      } else {
        // Handle network errors
        print('Network error: $e');
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'error': 'Network Error: $e'},
        );
      }
    }
  }

  Future<Response<dynamic>> registerUser(
      String email, String password, String authKey) async {
    try {
      Response response = await _dio.post(
        'https://buildexpo.us/wp-json/wp/v2/users',
        data: {
          'email': email,
          'password': password,
          'AUTH_KEY': authKey,
        },
      );
      //returns the successful json object
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // Return the error response if available
        return e.response!;
      } else {
        // Handle network errors, you might want to throw an exception or return a custom error response
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'error': 'Network Error'},
        );
      }
    }
  }

  // just sends the default wordpress reset password email
  Future<Response<dynamic>> resetPwEmail(String email) async {
    try {
      Response response = await _dio.post(
        'https://buildexpo.us/?rest_route=/simple-jwt-login/v1/user/reset_password',
        queryParameters: {
          'email': email,
        },
      );
      return response;
    } on DioException catch (e) {
      // Handle DioError
      if (e.response != null) {
        // Return the error response if available
        return e.response!;
      } else {
        // Handle network errors, you might want to throw an exception or return a custom error response
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'error': 'Network Error $e'},
        );
      }
    }
  }

  Future<Response<dynamic>> getUserInfo(String? jwt, String username) async {
    try {
      Response response = await _dio.post(
          'https://buildexpo.us/wp-json/wp/v2/users/me',
          queryParameters: {
            'Authorization': jwt,
            'username': username,
          });
      return response;
    } on DioException catch (e) {
      // Handle DioError
      if (e.response != null) {
        // Return the error response if available
        return e.response!;
      } else {
        // Handle network errors, you might want to throw an exception or return a custom error response
        return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'error': 'Network Error $e'},
        );
      }
    }
  }

  // Method to revoke JWT token
  Future<void> logout(String? jwt) async {
    if (jwt != null) {
      try {
        Response response = await _dio.post(
          'https://buildexpo.us/wp-json/api/v1/revoke-token',
          data: {'token': jwt},
        );

        if (response.statusCode == 200) {
          // Logout successful
          print('Logout successful');
        } else {
          // Logout failed - handle error
          print('Logout failed with status code ${response.statusCode}');
          print('Response body: ${response.data}');
        }
      } on DioException catch (e) {
        // Handle DioError
        print('Logout error: $e');
      }
    }
  }

  // Create QR Code
}
