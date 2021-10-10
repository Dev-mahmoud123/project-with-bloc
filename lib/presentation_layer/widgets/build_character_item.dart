import 'package:bloc_pattern_project/constants/constants.dart';
import 'package:bloc_pattern_project/data_layer/models/characters_model.dart';
import 'package:flutter/material.dart';

class BuildCharacterItem extends StatelessWidget {
  final CharacterModel character;

  const BuildCharacterItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: MyColors.myWhite,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            characterDetailsScreen,
            arguments: character,
          );
        },
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              width: double.infinity,
              color: MyColors.myGrey,
              child: character.img.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.img,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(
                        Icons.info,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 8.0,
            ),
            alignment: Alignment.center,
            color: Colors.black38,
            child: Text(
              character.name,
              style: const TextStyle(
                fontSize: 16.0,
                color: MyColors.myWhite,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
