
import 'package:flutter/material.dart';

class BuildCharacterInfo extends StatelessWidget {
  final String title ;
  final String value;

  const BuildCharacterInfo({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ]
        ),);
  }
}
