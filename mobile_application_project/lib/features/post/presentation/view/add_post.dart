import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_bloc.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_event.dart';
import 'package:mobile_application_project/features/post/presentation/view_model/post_state.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Add this package to pubspec.yaml

class CreatePostView extends StatefulWidget {
  final String userId;

  const CreatePostView({super.key, required this.userId});

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView>
    with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _imagePath;
  bool _isLoading = false;

  // Shake detection variables
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool _shakeDetectionEnabled = false;
  DateTime? _lastShakeTime;
  bool _createPostTriggered = false;
  Timer? _shakeDetectionTimer;

  // Constants for shake detection
  final double _shakeThreshold = 8.0; // Higher threshold for aggressive shake
  final Duration _cooldownBetweenShakes = const Duration(milliseconds: 500);
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Schedule initialization for after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initializeShakeDetection();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopShakeDetection();
    _textController.dispose();
    _shakeDetectionTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop detection when app is in background
    if (state == AppLifecycleState.paused) {
      _stopShakeDetection();
    } else if (state == AppLifecycleState.resumed &&
        !_createPostTriggered &&
        _isInitialized) {
      // Re-initialize when app comes back to foreground
      _initializeShakeDetection();
    }
  }

  void _initializeShakeDetection() {
    _isInitialized = true;

    // Start the 15-second timer before activating shake detection
    _shakeDetectionTimer?.cancel();
    _shakeDetectionTimer = Timer(const Duration(seconds: 5), () {
      if (!_createPostTriggered && mounted) {
        _startShakeDetection();
      }
    });

    // Now it's safe to show a SnackBar since the widget is fully built
    if (mounted) {
      showMySnackBar(
        context: context,
        message: 'Shake detection will activate in 5 seconds',
        color: Colors.blue,
      );
    }
  }

  void _startShakeDetection() {
    if (_shakeDetectionEnabled || !mounted) return;

    _shakeDetectionEnabled = true;

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      _detectShake(event);
    });

    if (mounted) {
      showMySnackBar(
        context: context,
        message:
            'Shake detection activated. Shake device aggressively to post!',
        color: Colors.green,
      );
    }
  }

  void _stopShakeDetection() {
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    _shakeDetectionEnabled = false;
    _shakeDetectionTimer?.cancel();
  }

  void _detectShake(AccelerometerEvent event) {
    if (_createPostTriggered || _isLoading || !mounted) return;

    // Calculate total acceleration
    double acceleration =
        event.x * event.x + event.y * event.y + event.z * event.z;
    acceleration =
        acceleration / (9.80665 * 9.80665); // Convert to g-force squared

    // Check if acceleration exceeds threshold (aggressive shake)
    if (acceleration > _shakeThreshold) {
      final now = DateTime.now();

      // Add cooldown to prevent multiple triggers for a single shake
      if (_lastShakeTime == null ||
          now.difference(_lastShakeTime!) > _cooldownBetweenShakes) {
        _lastShakeTime = now;

        _createPostTriggered = true;
        _stopShakeDetection();

        // Trigger post submission on UI thread
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          showMySnackBar(
            context: context,
            message: 'Aggressive shake detected! Creating post...',
            color: Colors.orange,
          );

          // Only submit if we have text content
          if (_textController.text.isNotEmpty) {
            _submitPost();
          } else {
            showMySnackBar(
              context: context,
              message: 'Please enter some text before shaking',
              color: Colors.red,
            );
            _createPostTriggered = false; // Reset to allow trying again
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostCreated) {
              showMySnackBar(
                context: context,
                message: 'Post created successfully!',
                color: Colors.green,
              );
              setState(() {
                _isLoading = false;
                _createPostTriggered =
                    true; // Ensure shake detection won't trigger again

                // Clear form for next post
                _textController.clear();
                _imagePath = null;
              });
            } else if (state is PostError) {
              showMySnackBar(
                context: context,
                message: state.message,
                color: Colors.red,
              );
              setState(() {
                _isLoading = false;
                _createPostTriggered =
                    false; // Allow retrying if there was an error
              });
            }
          },
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  // Text Field for Post Content
                  TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'What\'s on your mind?',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Display Selected Image
                  if (_imagePath != null)
                    Image.file(
                      File(_imagePath!),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),

                  // Pick Image Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 16),
                  // Submit Button
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitPost,
                      child: const Text('Create Post'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Picks an image from the gallery.
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
      if (mounted) {
        showMySnackBar(
          context: context,
          message: 'Failed to pick image: ${e.toString()}',
          color: Colors.red,
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Submits the post.
  void _submitPost() {
    if (_textController.text.isEmpty) {
      showMySnackBar(
        context: context,
        message: 'Please enter some text',
        color: Colors.red,
      );
      _createPostTriggered = false; // Reset to allow trying again
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Dispatch the CreatePostEvent
    context.read<PostBloc>().add(
          CreatePostEvent(
            postedBy: widget.userId,
            text: _textController.text,
            img: _imagePath,
          ),
        );
  }
}
