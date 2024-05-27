import 'package:flutter/material.dart';

class LanguageEntity{
  final String title;
  final String icon;
  final Locale locale;
  const LanguageEntity({required this.icon, required this.locale, required this.title});

  @override
  String toString() {
    return 'LanguageEntity(title: $title, icon: $icon)';
  }
}