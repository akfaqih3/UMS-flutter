import 'package:dio/dio.dart';
import 'package:lecture_2/config/constant/api_const.dart';
import 'package:lecture_2/helpers/token_storage.dart';
import 'package:lecture_2/controllers/login_controller.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
    ),
  );

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add access token to header
        final String? token = await TokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer ${token}';
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        // If token is expired, refresh token
        if (error.response?.statusCode == 401) {
          try {
            await _refreshToken(); // Refresh the token

            // Update the original request with the new token
            final String? newToken = await TokenStorage.getAccessToken();
            if (newToken != null) {
              error.requestOptions.headers['Authorization'] = 'Bearer $newToken';

              // Retry the failed request
              final options = error.requestOptions;
              final response = await _dio.fetch(options);
              return handler.resolve(response);
            }
          } catch (e) {
            // Handle error during refresh
            print('Error during token refresh: $e');
          }
        }

        return handler.next(error);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));
  }

  Dio get dio => _dio;
}

// function to refresh token
Future<void> _refreshToken() async {
  var refreshToken = await TokenStorage.getRefreshToken();
  if (refreshToken == null) {
    return;
  }
  final response = await DioClient().dio.post(
    Endpoints.refresh,
    data: {
      'refresh': refreshToken,
    },
  );
  if (response.statusCode == 200) {
    final data = response.data;
    TokenStorage.clearToken();
    await TokenStorage.saveToken(data['access'], data['refresh']);
  }
}