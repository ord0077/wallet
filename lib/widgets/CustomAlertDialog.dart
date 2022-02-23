import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../models/categoryModel.dart';
import '../screens/Dashboard.dart';

Future<void> _opensubCatgory(BuildContext context,String heading, List<SubCategory> SubCategoryList) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
     return new AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        title: new Text(
          heading,
          style:
              new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: new Container(
          // Specify some width
          width: MediaQuery.of(context).size.width * .7,
          child: Center(
            child: Container(
              child: SubCategoryGrid(
                  SubCategoryList, gridClicked),
            ),
          ),
        ),
        actions: <Widget>[
          new IconButton(
              splashColor: Colors.green,
              icon: new Icon(
                Icons.done,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}
Padding SubCategoryGrid(
    List<SubCategory> snapshot, Function gridClicked) {
  return Padding(
    padding: EdgeInsets.only( bottom: 5.0, top: 5.0),
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: snapshot.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: SubCategoryCell(snapshot[index]),
          onTap: () => gridClicked(context, snapshot[index]),
        );
      },
    ),
  );
}
