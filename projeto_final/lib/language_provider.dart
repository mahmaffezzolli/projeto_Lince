import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = Locale('en'); // Padrão para Inglês

  Locale get currentLocale => _currentLocale;

  void updateLanguage(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}
