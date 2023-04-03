import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class ProfanityFilterProvider extends ChangeNotifier {
  String text = '';
  bool isProfane = false;
  List<String> profanityList = [];
  final filter = ProfanityFilter();

  void checkProfanity(String text) {
    isProfane = filter.hasProfanity(text);
    notifyListeners();
  }

  void getProfanity(String text) {
    profanityList = filter.getAllProfanity(text);
    notifyListeners();
  }

  void clearText() {
    text = '';
    notifyListeners();
  }

  void setText(String text) {
    this.text = text;
    notifyListeners();
  }
}
