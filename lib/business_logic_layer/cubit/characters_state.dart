part of 'characters_cubit.dart';


@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  final List<CharacterModel> characters;

  CharactersLoading(this.characters);
}

class QuoteLoading extends CharactersState{
  final List<Quote> quotes;

  QuoteLoading(this.quotes);
}