import 'package:flutter/material.dart';

SizedBox getBaseButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 48.0,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
      child: Text(text),
    ),
  );
}
