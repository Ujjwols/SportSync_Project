import 'package:flutter/material.dart';
import 'package:mobile_application_project/app/app.dart';
import 'package:mobile_application_project/app/di/di.dart';
import 'package:mobile_application_project/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  await initDependencies();
  runApp(
    const App(),
  );
}
