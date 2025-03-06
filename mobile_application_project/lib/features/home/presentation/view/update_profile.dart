import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_project/features/auth/presentation/view_model/update/update_bloc.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _profilePic;

  Future<void> _pickProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePic = pickedFile.path; // Store the file path
      });
    }
  }

  void _submitUpdate() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<UpdateUserBloc>(context).add(
        UpdateUserRequested(
          name: _nameController.text,
          email: _emailController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          profilePic: _profilePic, // Pass the local file path
          password: _passwordController.text.isNotEmpty
              ? _passwordController.text
              : null,
        ),
      );
    }
  }

  String? _validatePassword(String? value) {
    if (value != null && value.isNotEmpty && value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            } else if (state is UpdateUserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<UpdateUserBloc, UpdateUserState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilePic != null
                            ? FileImage(File(_profilePic!))
                            : null,
                        child: _profilePic == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickProfilePicture,
                      child: const Text('Upload Profile Picture'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter name' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter username' : null,
                    ),
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(labelText: 'Bio'),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: 'New Password'),
                      obscureText: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 20),
                    state is UpdateUserLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submitUpdate,
                            child: const Text('Update Profile'),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
