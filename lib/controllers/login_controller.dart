import 'package:dio/dio.dart';
import 'package:lecture_2/API/dio_client.dart';
import 'package:lecture_2/models/login_model.dart';
import 'package:lecture_2/helpers/token_storage.dart';
import 'package:lecture_2/views/screens/home_screen.dart';
import 'package:lecture_2/views/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:lecture_2/API/api_service.dart';
import 'package:lecture_2/config/constant/api_const.dart';

class LoginController extends GetxController {
  final ApiService _ApiService = ApiService();
  String? accessToken;
  String? refreshToken;
  RxString status = 'login'.obs;

  @override
  void onInit() async {
    super.onInit();
    accessToken = await TokenStorage.getAccessToken();
    refreshToken = await TokenStorage.getRefreshToken();
    if (accessToken != null) {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      status('loading');
      final response = await _ApiService.post(Endpoints.login,
          data: {"email": email, "password": password},
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        final login = LoginModel.fromJson(response.data);
        accessToken = login.accessToken;
        refreshToken = login.refreshToken;
        await TokenStorage.saveToken(accessToken!, refreshToken!);
        Get.snackbar('Success', 'Login Successful');
        status('success');
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar('Error', 'Invalid username or password');
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid username or password');
    } finally {
      status('login');
    }
  }

  void logout() async {
    try {
      final response = await _ApiService.post(Endpoints.logout,
          data: {'refresh': refreshToken},
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        accessToken = null;
        refreshToken = null;
        await TokenStorage.clearToken();
        Get.snackbar('Success', 'Logout Successful');
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Logout Failed');
    }
  }
}
