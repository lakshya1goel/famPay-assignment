import '../../data/models/home_section_model.dart';

abstract class HomeSectionRepository {
  Future<List<HomeSection>> getHomeSection({String slug});
}