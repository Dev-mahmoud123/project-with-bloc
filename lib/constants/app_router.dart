import 'package:bloc_pattern_project/business_logic_layer/cubit/characters_cubit.dart';
import 'package:bloc_pattern_project/constants/constants.dart';
import 'package:bloc_pattern_project/data_layer/apis/character_api.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:bloc_pattern_project/data_layer/repositories/character_repository.dart';
import 'package:bloc_pattern_project/presentation_layer/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharacterApi());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => CharactersCubit(charactersRepository),
              child: CharacterDetailsScreen(
                character: character,
              ),
            );
          },
        );
    }
  }
}
