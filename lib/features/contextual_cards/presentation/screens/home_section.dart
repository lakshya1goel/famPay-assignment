import 'package:fam_assignment/features/contextual_cards/presentation/widgets/contextual_card_list_container.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Image.asset('assets/fampaylogo.png'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const ContextualCardListContainer(),
    );
  }
}
