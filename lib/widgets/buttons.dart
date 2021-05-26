import 'package:flutter/material.dart';

SizedBox getBaseButton({required String text, required VoidCallback onPressed}) {
  return SizedBox(
      height: 48.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text(text),
        onPressed: onPressed,
        textColor: Colors.white,
        color: Colors.blue,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ));
}
