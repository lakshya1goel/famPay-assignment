import 'package:fam_assignment/config/constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/home_section_model.dart';

abstract class HomeSectionRemoteDataSource {
  Future<List<HomeSection>> fetchHomeSection({String slug});
}

class HomeSectionRemoteDataSourceImpl implements HomeSectionRemoteDataSource {
  final ApiClient client = ApiClient();

  @override
  Future<List<HomeSection>> fetchHomeSection({
    String slug = "famx-paypage",
  }) async {
    final response = await client.get(
      "${AppConstants.homeSectionEndpoint}?slugs=$slug",
    );
    return response.map((e) => HomeSection.fromJson(e)).toList();
  }
}
