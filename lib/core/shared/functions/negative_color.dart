import 'package:flutter/material.dart';

Color invertColor(Color color) {
  return Color.fromARGB(
    color.alpha, 
    255 - color.red, 
    255 - color.green, 
    255 - color.blue, 
  );
}
