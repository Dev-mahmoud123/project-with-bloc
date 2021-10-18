import 'package:bloc_pattern_project/business_logic_layer/cubit/characters_cubit.dart';
import 'package:bloc_pattern_project/constants/constants.dart';
import 'package:bloc_pattern_project/constants/my_colors.dart';
import 'package:bloc_pattern_project/data_layer/apis/character_api.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:bloc_pattern_project/presentation_layer/widgets/build_character_item.dart';
import 'package:bloc_pattern_project/presentation_layer/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedCharacters;

  bool _isSearched = false;
  final _searchedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).retrieveAllCharacters();
  }

  /// TODO: On refresh Function
  Future<dynamic> refreshCharacters(BuildContext context) async {
   return CharacterApi().getAllCharacters();
  }

  /// TODO : Bloc Builder Widget
  Widget blocBuilderWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          allCharacters = (state).characters;
          return SingleChildScrollView(
            child: Container(
              color: MyColors.myGrey,
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _searchedController.text.isEmpty
                        ? allCharacters.length
                        : searchedCharacters.length,
                    itemBuilder: (context, index) => BuildCharacterItem(
                        character: _searchedController.text.isEmpty
                            ? allCharacters[index]
                            : searchedCharacters[index]),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /// TODO : Text field widget
  Widget buildTextField() {
    return TextField(
        controller: _searchedController,
        cursorColor: MyColors.myGrey,
        decoration: const InputDecoration(
          hintText: 'Search Character here...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: MyColors.myGrey,
            fontSize: 18.0,
          ),
        ),
        style: const TextStyle(
          color: MyColors.myGrey,
          fontSize: 18.0,
        ),
        onChanged: (searchedCharacter) {
          addSearchedItemToSearchedList(searchedCharacter);
        });
  }

  /// TODO : Search Function
  void addSearchedItemToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  /// TODO : Build App Bar Actions
  List<Widget> buildAppBarActions() {
    if (_isSearched) {
      return [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search, color: MyColors.myGrey),
          onPressed: _startSearching,
        )
      ];
    }
  }

  /// TODO: when pressed on search Icon
  void _startSearching() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );
    setState(() {
      _isSearched = true;
    });
  }

  /// TODO : stop search
  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearched = false;
    });
  }

  /// TODO : clear text field
  void _clearSearch() {
    setState(() {
      _searchedController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearched
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : const SizedBox.shrink(),
        title: _isSearched
            ? buildTextField()
            : const Text(
                'Characters',
                style: TextStyle(
                  color: MyColors.myGrey,
                ),
              ),
        backgroundColor: MyColors.myYellow,
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return RefreshIndicator(
              onRefresh: ()=> refreshCharacters(context),
              child: blocBuilderWidget(),
            );
          } else {
            return const NoInternetWidget();
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
