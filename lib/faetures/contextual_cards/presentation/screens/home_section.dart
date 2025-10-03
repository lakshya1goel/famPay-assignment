import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_bloc.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_event.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSectionBloc, HomeSectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home Section"),
          ),
          body: Column(
            children: [
              if (state is HomeSectionLoading)
                const Center(child: CircularProgressIndicator()),
              if (state is HomeSectionLoaded)
                Text("Home Section"),
              ElevatedButton(onPressed: () {
                context.read<HomeSectionBloc>().add(FetchHomeSectionEvent());
              }, child: Text("Get Cards")),
            ],
          ),
        );
      },
    );
  }
}