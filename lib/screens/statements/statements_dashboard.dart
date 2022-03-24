import 'package:flutter/cupertino.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
class Statements extends StatelessWidget {
  const Statements({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 2, right: 2, bottom: 2, top: 2),
            child: Column(
              children: [

              ],
            ),
          ),
        )
      ],
    );
  }
}
