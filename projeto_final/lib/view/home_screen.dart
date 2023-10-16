import 'package:flutter/material.dart';
import 'package:projeto_final/view/initial_screen.dart';
import 'package:projeto_final/view/register_screen.dart';
import 'package:projeto_final/view/settings_screen.dart';
import 'package:projeto_final/view/store_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color fundo = Color.fromRGBO(255, 255, 255, 1);

class HomeScreen extends StatelessWidget {
  final String? lastUser;
  const HomeScreen({Key? key, this.lastUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Consumer<ChangeNotifierProviderNavigation>(
        builder: (context, navigationState, _) {
          final selectedPage =
              navigationState.widgetOptions[navigationState.selectedIndex];

          return Scaffold(
            body: Center(
              child: selectedPage,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Color.fromRGBO(70, 130, 169, 1),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                  backgroundColor: Color.fromRGBO(116, 155, 194, 1),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add_circle_outline),
                  label: AppLocalizations.of(context)!.register,
                  backgroundColor: const Color.fromRGBO(145, 200, 228, 1),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.title,
                  backgroundColor: const Color.fromRGBO(181, 212, 228, 1),
                ),
              ],
              currentIndex: navigationState.selectedIndex,
              selectedItemColor: Colors.black,
              onTap: navigationState.onItemTapped,
            ),
          );
        },
      ),
    );
  }
}

class ChangeNotifierProviderNavigation with ChangeNotifier {
  int _selectedIndex = 0;
  String? lastUser; // Adicione a propriedade lastUser

  int get selectedIndex => _selectedIndex;

  final List<Widget> widgetOptions = <Widget>[
    const Initial(),
    const StoreList(),
    RegisterScreen(),
    const Settings(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
