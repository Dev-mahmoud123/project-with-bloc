import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_pattern_project/business_logic_layer/cubit/characters_cubit.dart';
import 'package:bloc_pattern_project/constants/my_colors.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:bloc_pattern_project/presentation_layer/widgets/build_character_info.dart';
import 'package:bloc_pattern_project/presentation_layer/widgets/build_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  /// TODO : Build Sliver App Bar
  Widget buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      expandedHeight: 600,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname!,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// TODO : Show Random Quotes
  Widget showRandomQuotesOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: Colors.white,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            pause:const Duration(milliseconds: 1000) ,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).retrieveQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildCharacterInfo(
                        title: 'Jobs : ',
                        value: character.occupation!.join(' / '),
                      ),
                      const BuildDivider(
                        endIndent: 315,
                      ),
                      BuildCharacterInfo(
                        title: 'Appeared in : ',
                        value: character.category!,
                      ),
                      const BuildDivider(
                        endIndent: 260,
                      ),
                      BuildCharacterInfo(
                        title: 'Seasons : ',
                        value: character.appearance.join(' / '),
                      ),
                      const BuildDivider(
                        endIndent: 285,
                      ),
                      BuildCharacterInfo(
                        title: 'Status : ',
                        value: character.status!,
                      ),
                      const BuildDivider(
                        endIndent: 300,
                      ),
                      character.betterCallSaulAppearance!.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildCharacterInfo(
                                  title: 'betterCallSaulAppearance : ',
                                  value: character.betterCallSaulAppearance!
                                      .join(' / '),
                                ),
                                const BuildDivider(
                                  endIndent: 150,
                                ),
                              ],
                            ),
                      BuildCharacterInfo(
                        title: 'Actor/Actress : ',
                        value: character.portrayed!,
                      ),
                      const BuildDivider(
                        endIndent: 250,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          if (state is QuoteLoading) {
                            return showRandomQuotesOrEmptySpace(state);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
