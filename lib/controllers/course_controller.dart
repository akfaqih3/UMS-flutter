import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:lecture_2/models/course_model.dart';
import 'package:lecture_2/API/api_service.dart';
import 'package:lecture_2/config/constant/api_const.dart';

class CourseController extends GetxController {
  final ApiService _apiService = ApiService();
  var courseList = <CourseModel>[].obs;
  CourseModel? courseDetail;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getCourseList();
  }

  Future<void> getCourseList() async {
    try {
      isLoading(true);
      final response = await _apiService.get(Endpoints.courses);
      if (response.statusCode == 200) {
        courseList.value = (response.data as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch subjects",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }

    update();
  }

  Future<void> getCourseDetails(int courseId) async {
    // try {
    //   isLoading(true);
    //   final response = await _apiService.get("${Endpoints.courses}$courseId/");
    //   if (response.statusCode == 200) {
    //     course = CourseModel.fromJson(response.data);
    //   }
    // } catch (e) {
    // } finally {
    //   isLoading(false);
    // }

    courseDetail =
        courseList.value.firstWhere((element) => element.id == courseId);
  }

  void addCourse({
    required String title,
    required String overview,
    required String subject,
    File? photo,
  }) async {
    var data;
    dio.Options options =
        dio.Options(headers: {'Content-Type': 'application/json'});
    try {
      isLoading(true);

      if (photo != null) {
        data = dio.FormData.fromMap({
          "subject": subject,
          "title": title,
          "overview": overview,
          "photo": dio.MultipartFile.fromFileSync(
            photo.path,
            filename: photo.path.split(Platform.pathSeparator).last,
          ),
        });
        options = dio.Options(headers: {'Content-Type': 'multipart/form-data'});
      } else {
        data = dio.FormData.fromMap({
          "subject": subject,
          "title": title,
          "overview": overview,
        });
      }

      final response = await _apiService.post(Endpoints.courseCreate,
          data: data, options: options);
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Course added successfully');
      } else {
        Get.snackbar('Error', response.data['error']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add course');
    } finally {
      isLoading(false);
    }

    getCourseList();
  }

  void updateCourse(
    int courseId, {
    required String title,
    required String overview,
    required String subject,
    File? photo,
  }) async {
    var data;
    dio.Options options = dio.Options(
      headers: {'method': 'PUT', 'Content-Type': 'application/json'},
    );
    try {
      isLoading(true);

      if (photo != null) {
        data = dio.FormData.fromMap({
          "subject": subject,
          "title": title,
          "overview": overview,
          "photo": dio.MultipartFile.fromFileSync(
            photo.path,
            filename: photo.path.split(Platform.pathSeparator).last,
          ),
        });
        options = dio.Options(
          headers: {'method': 'PUT', 'Content-Type': 'multipart/form-data'},
        );
      } else {
        data = dio.FormData.fromMap({
          "subject": subject,
          "title": title,
          "overview": overview,
        });
      }

      final response = await _apiService.put(
          '${Endpoints.course}$courseId/update/',
          data: data,
          options: options);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Course updated successfully');
        Get.back();
      } else {
        Get.snackbar('Error', response.data['error']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update course');
    } finally {
      isLoading(false);
    }

    getCourseList();
  }

  void deleteCourse(int courseId) async {
    try {
      isLoading(true);

      final response =
          await _apiService.delete('${Endpoints.course}$courseId/delete/');
      if (response.statusCode == 204) {
        Get.snackbar('Success', 'Course deleted successfully');
        Get.back();
      } else {
        Get.snackbar('Error', response.data['error']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete course');
    } finally {
      isLoading(false);
    }
    getCourseList();
  }
}
