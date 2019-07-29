import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "My Crew" : titleText,
      style: TextStyle(
          fontSize: isAppTitle ? 48.0 : 24.0,
          fontFamily: isAppTitle ? "Signatra" : "",
          color: Colors.blue),
    ),
    centerTitle: true,
  );
}
