import 'package:fam_assignment/config/dependency_injection.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/bloc/home_section_bloc.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/widgets/factories/card_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContextualCardListContainer extends StatelessWidget {
  const ContextualCardListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<HomeSectionBloc>()..add(FetchHomeSectionEvent()),
      child: const _ContextualCardListView(),
    );
  }
}

class _ContextualCardListView extends StatelessWidget {
  const _ContextualCardListView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<HomeSectionBloc, HomeSectionState>(
        builder: (context, state) {
          if (state is HomeSectionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeSectionError) {
            return _buildError(context, state.message);
          }

          if (state is HomeSectionEmpty) {
            return const Center(child: Text("No contextual cards available"));
          }

          if (state is HomeSectionLoaded) {
            return _buildCardList(
              context,
              state.homeSections,
              state.hiddenCardIds,
            );
          }

          return _buildInitial(context);
        },
      ),
    );
  }

  Widget _buildCardList(
    BuildContext context,
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

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          const Text(
            'Oops! Something went wrong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
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
