import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_bloc.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/widgets/factories/card_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeSectionBloc>().add(FetchHomeSectionEvent());
  }

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
      body: BlocBuilder<HomeSectionBloc, HomeSectionState>(
        builder: (context, state) {
          if (state is HomeSectionLoading) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is HomeSectionError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildError(state.message),
            );
          }

          if (state is HomeSectionEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Center(child: Text("No contextual cards available")),
            );
          }

          if (state is HomeSectionLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildCardList(state.homeSections, state.hiddenCardIds),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildInitial(),
          );
        },
      ),
    );
  }

  Widget _buildCardList(
    List<dynamic> homeSections,
    List<String> hiddenCardIds,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeSectionBloc>().add(FetchHomeSectionEvent());
      },
      child: ListView.builder(
        itemCount: homeSections.length,
        padding: const EdgeInsets.only(bottom: 15),
        itemBuilder: (context, index) {
          final homeSection = homeSections[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (homeSection.title != null && homeSection.title!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    homeSection.title!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ...CardFactory.buildAllCardGroups(
                homeSection.hcGroups,
                hiddenCardIds,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeSectionBloc>().add(FetchHomeSectionEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.credit_card_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Welcome to Fam Pay',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<HomeSectionBloc>().add(FetchHomeSectionEvent());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text("Load Cards"),
          ),
        ],
      ),
    );
  }
}
