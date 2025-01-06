import 'package:flutter/material.dart';
import 'package:lecture_2/config/route/routes.dart';
import 'package:get/get.dart';
import 'package:lecture_2/controllers/login_controller.dart';
import 'package:lecture_2/views/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginController _controller = Get.put(LoginController());

    return Scaffold(
      body: Center(
        child: Material(
          elevation: 4.0,
          color: Color.fromARGB(255, 255, 95, 12),
          borderRadius: BorderRadius.circular(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: ClipPath(
              clipper: CustomCard(),
              child: Container(
                width: 300,
                height: 400,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          controller: _emailController,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: 'login',
                          color: Color.fromARGB(255, 255, 95, 12),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _controller.login(_emailController.text,
                                  _passwordController.text);
                            } else {
                              Get.snackbar(
                                  'Error', 'Invalid username or password');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.0,
        size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.2, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
