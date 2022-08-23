import 'package:flutter/material.dart';




final textFieldDecoration = InputDecoration(
  hintText: '',
  filled: true,
  fillColor: Colors.blueGrey[100],
  icon: Icon(
    Icons.account_circle_outlined,
    color: Colors.blueAccent,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  )
);
