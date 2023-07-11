import 'package:flutter/material.dart';

enum Categories {
  carbs,
  convenience,
  dairy,
  fruit,
  hygiene,
  meat,
  spices,
  sweets,
  vegetables,
  other
}

class Category {
  const Category(
    this.title,
    this.color,
  );

  final String title;
  final Color color;
}
