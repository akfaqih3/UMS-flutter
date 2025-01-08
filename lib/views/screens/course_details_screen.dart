import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture_2/controllers/course_controller.dart';
import 'package:lecture_2/helpers/constants.dart';
import 'package:lecture_2/config/constant/api_const.dart';
import 'package:lecture_2/models/course_model.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseController _controller = Get.put(CourseController());
  final int courseId;

  CourseDetailsScreen(this.courseId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Course Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 10,
        shadowColor: primaryColor.withOpacity(0.5),
      ),
      body: Container(
        width: 500,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.black12),
        child: Obx(() {
          CourseModel course = _controller.getCourseDetails(courseId);

          if (course == null) {
            return const Center(
              child: Text(
                "No course available.",
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            );
          }

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "${baseUrl + course.photo!}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.error,
                            color: primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "subject: ${_controller.courseList[courseId].subject}",
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.delete,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
