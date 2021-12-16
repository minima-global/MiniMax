import 'package:flutter/material.dart';
import 'package:minimax/res/images/images.dart';

Widget withGlossyBackground({required Widget body}) {
  return Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageKeys.glossyBrightBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body,
    ],
  );
}
