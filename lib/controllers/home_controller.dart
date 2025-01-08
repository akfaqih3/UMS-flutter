import 'package:get/get.dart';
import 'package:lecture_2/API/api_service.dart';
import 'package:lecture_2/models/subject_model.dart';
import 'package:lecture_2/config/constant/api_const.dart';

class HomeController extends GetxController {
  var subjects = <SubjectModel>[].obs; // Observable list of subjects
  var isLoading = true.obs; // Loading state

  final ApiService _apiService = ApiService(); // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  // Fetch subjects from API
  Future<void> fetchSubjects() async {
    try {
      isLoading(true);
      final response = await _apiService.get(Endpoints.subject);
      if (response.statusCode == 200) {
        // Parse the response into a list of Subject objects
        subjects.value = (response.data as List)
            .map((json) => SubjectModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch subjects",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
