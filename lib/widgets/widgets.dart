// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'GATE',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 23)),
        TextSpan(
            text: 'prep',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.amber,
                fontSize: 23)),
      ],
    ),
  );
}

Widget amberButton({BuildContext? context, String? lable, buttonWidth}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      width: buttonWidth != null
          ? buttonWidth
          : MediaQuery.of(context!).size.width - 48,
      child: Text(
        lable!,
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ));
}
