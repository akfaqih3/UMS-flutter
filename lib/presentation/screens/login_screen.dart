import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String username = '';
    String password = '';

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
                color: Colors.white ,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            username = value ?? '';
                          },
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
                          onSaved: (value) {
                            password = value ?? '';
                          },
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: 'Login',
                          color: Color.fromARGB(255, 255, 95, 12),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              _controller.login(username, password);
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
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.0, size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.2, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
