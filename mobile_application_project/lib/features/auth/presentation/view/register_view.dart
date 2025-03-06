import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: '');
  final _usernameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  // // Check for camera permission
  // Future<void> checkCameraPermission() async {
  //   if (await Permission.camera.request().isRestricted ||
  //       await Permission.camera.request().isDenied) {
  //     await Permission.camera.request();
  //   }
  // }

  // File? _img;
  // Future _browseImage(ImageSource imageSource) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: imageSource);
  //     if (image != null) {
  //       setState(() {
  //         _img = File(image.path);
  //         // Send image to server
  //         context.read<RegisterBloc>().add(
  //               UploadImage(file: _img!),
  //             );
  //       });
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'SportsSync',
                    style: TextStyle(
                      fontFamily: 'Cursive', // Adjust font if needed
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Logo
                  CircleAvatar(
                    radius: 60.0, // Adjust radius to control size
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage(
                      'assets/icons/logo.png', // Replace with correct path
                    ),
                  ),
                  const SizedBox(height: 40.0),
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
                    'Register your Team',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // const SizedBox(height: 16.0),
                  // InkWell(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       backgroundColor: Colors.grey[300],
                  //       context: context,
                  //       isScrollControlled: true,
                  //       shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //           top: Radius.circular(20),
                  //         ),
                  //       ),
                  //       builder: (context) => Padding(
                  //         padding: const EdgeInsets.all(20),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             ElevatedButton.icon(
                  //               onPressed: () {
                  //                 checkCameraPermission();
                  //                 _browseImage(ImageSource.camera);
                  //                 Navigator.pop(context);
                  //               },
                  //               icon: const Icon(Icons.camera),
                  //               label: const Text('Camera'),
                  //             ),
                  //             ElevatedButton.icon(
                  //               onPressed: () {
                  //                 _browseImage(ImageSource.gallery);
                  //                 Navigator.pop(context);
                  //               },
                  //               icon: const Icon(Icons.image),
                  //               label: const Text('Gallery'),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: SizedBox(
                  //     height: 200,
                  //     width: 200,
                  //     child: CircleAvatar(
                  //       radius: 50,
                  //       backgroundImage: _img != null
                  //           ? FileImage(_img!)
                  //           : const AssetImage('assets/images/profile.png')
                  //               as ImageProvider,
                  //       // backgroundImage:
                  //       //     const AssetImage('assets/images/profile.png')
                  //       //         as ImageProvider,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20.0),
                  // Team Name (Username) Input
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'TeamFullName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Team name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Team Name (Username) Input
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
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
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          final registerState =
                              context.read<RegisterBloc>().state;
                          context.read<RegisterBloc>().add(
                                RegisterUser(
                                  context: context,
                                  name: _nameController.text,
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
          ),
        ),
      ),
    );
  }
}
