
import 'package:bloc_pattern_project/constants/my_colors.dart';
import 'package:flutter/material.dart';

class BuildDivider extends StatelessWidget {
  final double endIndent ;
  const BuildDivider({Key? key,required this.endIndent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: MyColors.myYellow,
      height: 30.0,
      thickness: 2.0,
      endIndent: endIndent ,
    );
  }
}
