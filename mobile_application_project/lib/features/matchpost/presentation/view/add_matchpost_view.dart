import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_bloc.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_event.dart';
import 'package:mobile_application_project/features/matchpost/presentation/view_model/matchpost_state.dart';

class CreateMatchPostView extends StatefulWidget {
  final String userId;

  const CreateMatchPostView({super.key, required this.userId});

  @override
  _CreateMatchPostViewState createState() => _CreateMatchPostViewState();
}

class _CreateMatchPostViewState extends State<CreateMatchPostView> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _gameTypeController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _imagePath;
  bool _isLoading = false;
  CameraController? _cameraController;
  bool _isCameraCovered = false;
  bool _isSensorActive = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _activateSensorAfterDelay();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.low,
      );
      await _cameraController!.initialize();
    } catch (e) {
      print("Camera initialization error: $e");
      // Handle the error or show an error message
    }
  }

  void _activateSensorAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _isSensorActive = true;
    });
    _monitorCameraFeed();
  }

  void _monitorCameraFeed() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    _cameraController!.startImageStream((CameraImage image) {
      final brightness = _calculateBrightness(image);
      if (brightness < 10) {
        // Adjust this threshold as needed
        setState(() {
          _isCameraCovered = true;
        });
      } else {
        setState(() {
          _isCameraCovered = false;
        });
      }
    });
  }

  double _calculateBrightness(CameraImage image) {
    // Calculate the average brightness of the image
    final plane = image.planes[0];
    final bytes = plane.bytes;
    int sum = 0;

    for (int i = 0; i < bytes.length; i++) {
      sum += bytes[i];
    }

    return sum / bytes.length;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Match Post'),
      ),
      body: _isCameraCovered
          ? Container(color: Colors.black)
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<MatchpostBloc, MatchpostState>(
                listener: (context, state) {
                  if (state is MatchPostCreated) {
                    showMySnackBar(
                      context: context,
                      message: 'Match post created successfully!',
                      color: Colors.green,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  } else if (state is MatchPostError) {
                    showMySnackBar(
                      context: context,
                      message: state.message,
                      color: Colors.red,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _teamNameController,
                            decoration: const InputDecoration(
                              labelText: 'Team Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a team name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a location';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Date (YYYY-MM-DD)',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a date';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _timeController,
                            decoration: const InputDecoration(
                              labelText: 'Time (HH:MM)',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a time';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _gameTypeController,
                            decoration: const InputDecoration(
                              labelText: 'Game Type',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a game type';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _paymentController,
                            decoration: const InputDecoration(
                              labelText: 'Payment',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter payment details';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          if (_imagePath != null)
                            Image.file(
                              File(_imagePath!),
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _pickImage,
                            child: const Text('Pick Image'),
                          ),
                          const SizedBox(height: 16),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              onPressed: _isLoading ? null : _submitMatchPost,
                              child: const Text('Create Match Post'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      showMySnackBar(
        context: context,
        message: 'Failed to pick image: ${e.toString()}',
        color: Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitMatchPost() {
    if (_textController.text.isEmpty ||
        _teamNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _gameTypeController.text.isEmpty ||
        _paymentController.text.isEmpty) {
      showMySnackBar(
        context: context,
        message: 'Please fill out all required fields',
        color: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    context.read<MatchpostBloc>().add(
          CreateMatchPostEvent(
            postedBy: widget.userId,
            text: _textController.text,
            img: _imagePath,
            teamName: _teamNameController.text,
            location: _locationController.text,
            date: _dateController.text,
            time: _timeController.text,
            gameType: _gameTypeController.text,
            payment: _paymentController.text,
          ),
        );
  }
}
