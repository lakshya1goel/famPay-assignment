import 'package:fam_assignment/core/network/api_client.dart';
import 'package:fam_assignment/core/services/storage_service.dart';
import 'package:fam_assignment/features/contextual_cards/data/datasources/home_section_remote_datasource.dart';
import 'package:fam_assignment/features/contextual_cards/data/repositories_impl/home_section_repository_impl.dart';
import 'package:fam_assignment/features/contextual_cards/domain/repositories/home_section_repository.dart';
import 'package:fam_assignment/features/contextual_cards/domain/usecases/home_section_usecase.dart';
import 'package:fam_assignment/features/contextual_cards/presentation/bloc/home_section_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  getIt.registerLazySingleton<StorageService>(
    () => StorageService(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerLazySingleton<HomeSectionRemoteDataSource>(
    () => HomeSectionRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<HomeSectionRepository>(
    () => HomeSectionRepositoryImpl(getIt<HomeSectionRemoteDataSource>()),
  );

  getIt.registerLazySingleton<HomeSectionUsecase>(
    () => HomeSectionUsecase(getIt<HomeSectionRepository>()),
  );

  getIt.registerFactory<HomeSectionBloc>(
    () => HomeSectionBloc(
      getIt<HomeSectionUsecase>(),
      getIt<StorageService>(),
    ),
  );
}