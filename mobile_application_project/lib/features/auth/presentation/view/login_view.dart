import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view/register_view.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _teamnameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    'assets/icons/logo.png', // Replace with correct path
                  ),
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
                      // Team Name (Username) Input
                      TextFormField(
                        controller: _teamnameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Teamname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Teamname';
                          }
                          return null;
                        },
                      ),
                      _gap,

                      // Password Input
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              LoginTeamEvent(
                                context: context,
                                teamName: _teamnameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(
                              NavigateRegisterScreenEvent(
                                context: context,
                                destination: const RegisterView(),
                              ),
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
      ),
    );
  }
}
