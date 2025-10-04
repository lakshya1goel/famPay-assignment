import 'package:fam_assignment/features/contextual_cards/data/datasources/home_section_remote_datasource.dart';
import 'package:fam_assignment/features/contextual_cards/domain/repositories/home_section_repository.dart';

import '../models/home_section_model.dart';

class HomeSectionRepositoryImpl implements HomeSectionRepository {
  final HomeSectionRemoteDataSource remote;

  HomeSectionRepositoryImpl(this.remote);

  @override
  Future<List<HomeSection>> getHomeSection({String slug = "famx-paypage"}) {
    return remote.fetchHomeSection(slug: slug);
  }
}