import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  //
  final String title;

  TitleHeader({@required this.title});

  @override
  Widget build(BuildContext context) {
    //
    double screenWith = MediaQuery.of(context).size.width;

    return Container(
      width: screenWith,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
