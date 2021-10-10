import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:bloc_pattern_project/data_layer/models/quote_model.dart';
import 'package:bloc_pattern_project/data_layer/repositories/character_repository.dart';
import 'package:flutter/material.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  ///  TODO : Characters Cubit
  List<CharacterModel> retrieveAllCharacters() {
    charactersRepository.fetchAllCharacters().then((characters) {
      emit(CharactersLoading(characters));
      this.characters = characters;
    });
    return characters;
  }

  ///  TODO : Quotes Cubit
  void retrieveQuotes(String charName) {
    charactersRepository.fetchQuotes(charName).then((quotes) {
      emit(QuoteLoading(quotes));
    });
  }
}
