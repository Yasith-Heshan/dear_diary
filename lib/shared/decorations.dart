import 'package:flutter/material.dart';

const authTextInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      width: 1,
      color: Colors.black,
    )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
      width: 1,
      color: Colors.blue,
    )
    )
);

InputDecoration noteInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(25),
    ),
    fillColor: const Color(0xFF3097DAFF),
    filled: true,
    hintText: 'Submit New',

);
