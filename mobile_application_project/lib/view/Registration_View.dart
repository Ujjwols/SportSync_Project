import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/Login_view.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
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

              // Logo
              CircleAvatar(
                radius: 60.0, // Adjust radius to control size
                backgroundColor: Colors.grey[200],
                backgroundImage: const AssetImage(
                    'assets/icons/logo.png'), // Replace with correct path
              ),
              const SizedBox(height: 40.0),

              const Text(
                'Create Your Team Account',
                style: TextStyle(
                  fontSize: 24.0,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Montseraat Bold',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Join SportsSync to manage your team effectively',
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
                      decoration: InputDecoration(
                        labelText: 'Team Name',
                        hintText: 'Enter your team name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your team name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Email Input
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+\$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
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
                        hintText: 'Create a password',
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
                      controller: confirmPasswordController,
                      obscureText: true,
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
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.black,
                  //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  // ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic here
                      print('Account created successfully');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Account created successfully')),
                      );
                    }
                  },
                  child: const Text(
                    'Create Account',
                    // style: TextStyle(
                    //   fontSize: 16.0,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.white,
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign-in screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                    child: const Text(
                      'Sign in here',
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
      ),
    );
  }
}
