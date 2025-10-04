import 'package:fam_assignment/app.dart';
import 'package:fam_assignment/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final storageService = await StorageService.init();

  runApp(MyApp(storageService: storageService));
}
