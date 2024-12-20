import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/Registration_View.dart';
import 'package:mobile_application_project/view/dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60.0),

              // App Name
              const Text(
                'SportsSync',
                style: TextStyle(
                  fontFamily: 'Cursive', // Adjust font if needed
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              // Logo
              CircleAvatar(
                radius: 60.0, // Adjust radius to control size
                backgroundColor: Colors.grey[200],
                backgroundImage: const AssetImage(
                    'assets/icons/logo.png'), // Replace with correct path
              ),
              const SizedBox(height: 40.0),

              // Welcome Text
              const Text(
                'Welcome to SportsSync',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Login to access your team dashboard',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Team Name Input
                    TextFormField(
                      controller: teamNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Team Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      autofillHints: const [AutofillHints.username],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your team name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Password Input
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      autofillHints: const [AutofillHints.password],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),

              // Remember Me and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password screen
                      print('Forgot password pressed');
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.black,
                      //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   shape: const RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(8.0),
                      //       ),
                      ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle login logic
                      print('Login successful');
                      // Navigate to DashboardView
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardView(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill out all fields')),
                      );
                    }
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        // fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                        // color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      // Navigate to RegistrationView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationView()),
                      );
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
