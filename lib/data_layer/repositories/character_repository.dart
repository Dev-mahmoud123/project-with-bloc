
import 'package:bloc_pattern_project/data_layer/apis/character_api.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:bloc_pattern_project/data_layer/models/quote_model.dart';

class CharactersRepository{

 final CharacterApi characterApi ;

 CharactersRepository(this.characterApi);

 /// TODO : Get All Characters
 Future<List<CharacterModel>> fetchAllCharacters()async{
   final characters = await characterApi.getAllCharacters();
   return characters.map((character) =>CharacterModel.fromJson(character)).toList();
 }

 /// TODO : Get Quotes
 Future<List<Quote>> fetchQuotes(String charName)async{
   final quotes = await characterApi.getQuotes(charName);
   return quotes.map((quote) =>Quote.fromJson(quote)).toList();
 }
}