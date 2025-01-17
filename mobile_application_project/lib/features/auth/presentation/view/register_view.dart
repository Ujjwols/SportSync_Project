import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/signup/register_bloc.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for form fields
    final teamnameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();

    // Create a GlobalKey for the Form
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const Text(
                'SportsSync',
                style: TextStyle(
                  fontFamily: 'Cursive', // Updated to match LoginView font
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              const Text(
                'Create Your Student Account',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Montseraat Bold',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              CircleAvatar(
                radius: 60.0, // Adjust radius to control size
                backgroundColor: Colors.grey[200],
                backgroundImage: const AssetImage(
                    'assets/icons/logo.png'), // Replace with correct path
              ),
              const SizedBox(height: 40.0),
              Text(
                'Join SportsSync to manage your Team',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),

              // Form
              Form(
                key: formKey, // Use the GlobalKey here
                child: Column(
                  children: [
                    // Team Name Input
                    TextFormField(
                      controller: teamnameController,
                      decoration: InputDecoration(
                        labelText: 'Team',
                        hintText: 'Enter your TeamName',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter TeamName';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Email Input
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter an email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Password Input
                    TextFormField(
                      controller: passwordController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Create a password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please create a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Confirm Password Input
                    TextFormField(
                      controller: confirmpasswordController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate form using the GlobalKey
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<RegisterBloc>().add(RegisterTeam(
                                  context: context,
                                  teamName: teamnameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmpasswordController.text,
                                ));
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Row with Registration Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        GestureDetector(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                  NavigateLoginScreenEvent(
                                    destination: LoginView(),
                                    context: context,
                                  ),
                                );
                          },
                          child: const Text(
                            'Login here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
