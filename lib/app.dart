import 'package:fam_assignment/config/theme.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/screens/contextual_cards_container.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamPay',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const ContextualCardsContainer(),
    );
  }
}