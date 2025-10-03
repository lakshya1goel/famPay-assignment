import '../repositories/home_section_repository.dart';
import '../../data/models/home_section_model.dart';

class HomeSectionUsecase {
  final HomeSectionRepository repository;

  HomeSectionUsecase(this.repository);

  Future<List<HomeSection>> fetchHomeSection({String slug = "famx-paypage"}) {
    return repository.getHomeSection(slug: slug);
  }
}