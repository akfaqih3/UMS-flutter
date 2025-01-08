import 'package:dio/dio.dart';
import 'package:lecture_2/API/dio_client.dart';

class ApiService {
  final DioClient _client = DioClient();

  //dyanamic post
  Future<dynamic> post(String url, {Object? data, Options? options}) async {
    Response response = await _client.dio.post(
      url,
      data: data,
      options: options,
    );
    return response;
  }

  //dynamic get
  Future<dynamic> get(String url) async {
    return await _client.dio.get(url);
  }
}
