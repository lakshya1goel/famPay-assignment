import 'package:fam_assignment/config/theme.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/datasources/home_section_remote_datasource.dart';
import 'package:fam_assignment/faetures/contextual_cards/data/repositories_impl/home_section_repository_impl.dart';
import 'package:fam_assignment/faetures/contextual_cards/domain/usecases/home_section_usecase.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/bloc/home_section_bloc.dart';
import 'package:fam_assignment/faetures/contextual_cards/presentation/screens/home_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeSectionBloc>(create: (context) => HomeSectionBloc(HomeSectionUsecase(HomeSectionRepositoryImpl(HomeSectionRemoteDataSourceImpl())))),
      ],
      child: MaterialApp(
      title: 'FamPay',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeSection(),
    ));
  }
}