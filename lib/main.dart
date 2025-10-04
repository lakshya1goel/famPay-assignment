import 'package:fam_assignment/app.dart';
import 'package:fam_assignment/config/dependency_injection.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/factories/card_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDependencyInjection();
  CardFactory.initialize();
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}
