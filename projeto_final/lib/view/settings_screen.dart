import 'package:flutter/material.dart';
import 'package:projeto_final/language_provider.dart';
import 'package:projeto_final/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  void saveLanguagePreference(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLanguage', newLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: null,
          body: Column(
            children: [
              Container(
                height: 130,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(70, 130, 169, 1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Title(
                          color: const Color.fromARGB(255, 44, 44, 44),
                          child: Text(
                            AppLocalizations.of(context)!.title,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(255, 27, 27, 27),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Language:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 150),
                    DropdownButton<Locale>(
                      value: languageProvider.currentLocale,
                      onChanged: (newLocale) {
                        languageProvider.updateLanguage(newLocale!);
                        saveLanguagePreference(newLocale);
                      },
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: Locale('pt'),
                          child: Text('Português'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                secondary: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.black,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
