import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture_2/controllers/course_controller.dart';
import 'package:lecture_2/controllers/home_controller.dart';
import 'package:lecture_2/controllers/login_controller.dart';
import 'package:lecture_2/helpers/constants.dart';
import 'package:lecture_2/config/constant/api_const.dart';
import 'package:lecture_2/views/screens/courses_screen.dart';
import 'package:lecture_2/views/screens/course_details_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CoursesScreen extends StatelessWidget {
  final CourseController _controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
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
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.black12),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          if (_controller.courseList.isEmpty) {
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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _controller.courseList.length,
            itemBuilder: (context, index) {
              final course = _controller.courseList[index];
              return AnimatedOpacity(
                opacity: _controller.isLoading.value ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Get.to(CourseDetailsScreen(course.id));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${baseUrl + course.photo!}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    // color: primaryColor,
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
                          const SizedBox(width: 16),
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
                                  "subject: ${course.subject}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog();
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddCourseDialog() {
    var subjects = Get.find<HomeController>().subjects;
    final _formKey = GlobalKey<FormState>();

    var titleController = TextEditingController();
    var overviewController = TextEditingController();
    String selectedSubject = subjects.first.slug;

    Rx<File?> courseImage = Rx<File?>(null);

    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        courseImage.value = File(pickedFile.path);
      }
    }

    Get.defaultDialog(
      title: 'New Course',
      content: Obx(() {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: subjects.isEmpty ? null : subjects.first.slug,
                  items: subjects
                      .map((e) => DropdownMenuItem(
                            value: e.slug,
                            child: Text(e.title),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedSubject = value!;
                  },
                  decoration: InputDecoration(labelText: 'Select Subject'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a subject'
                      : null,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a course name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    titleController.text = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Overview'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    overviewController.text = value!;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Choose Course photo'),
                ),
                Obx(() {
                  return courseImage.value == null
                      ? Text('No image selected')
                      : Image.file(
                          courseImage.value!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        );
                }),
              ],
            ),
          ),
        );
      }),
      textCancel: 'Cancel',
      textConfirm: 'Save',
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (selectedSubject == null) {
            Get.snackbar('Error', 'Please select a subject');
            return;
          }

          _controller.addCourse(
            title: titleController.text,
            overview: overviewController.text,
            subject: selectedSubject,
            photo: courseImage.value,
          );

          Get.back();
        }
      },
    );
  }
}
