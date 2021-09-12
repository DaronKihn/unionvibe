import 'package:flutter/material.dart';

const kMainColor = Color(0xFF0A0E21);
const kTranslucentColor = Color(0x150A0E21);

const kLinearGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFd0dfff),
    Color(0xFFe2d9f0),
    Color(0xFFf1e3c8),
  ],
);
const kLinearGradientReversed = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.bottomLeft,
  colors: [
    Color(0xFFd0dfff),
    Color(0xFFe2d9f0),
    Color(0xFFf1e3c8),
  ],
);
