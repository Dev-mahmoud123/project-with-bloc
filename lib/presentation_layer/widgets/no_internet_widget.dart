import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/warning.png',
          width: double.infinity,
          height: 300.0,
          fit: BoxFit.fill,
        ),
        const Text(
          'There is no internet ,\n please check your internet connection!',
          style: TextStyle(color: Colors.black45 , fontSize: 18.0),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
