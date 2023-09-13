import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final/storages/user_database.dart';
import '../entities/store.dart';
import 'store_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<ChangeNotifierProviderNavigation>(
        builder: (context, navigationState, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(246, 244, 235, 1),
            title: const Text(
              'Olá, seja bem-vindo',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: navigationState.widgetOptions
                .elementAt(navigationState.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: navigationState.selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: navigationState.onItemTapped,
          ),
        ),
      ),
    );
  }
}

class ChangeNotifierProviderNavigation with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> widgetOptions = <Widget>[
    const StoreList(),
    const Text(
      'Index 1: Business',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Index 2: School',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Index 3: Settings',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class StoreList extends StatelessWidget {
  const StoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Store>>(
      future:
          Provider.of<StoreController>(context, listen: false).getAllStores(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading stores');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No stores found');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Store store = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreDetailsScreen(store: store),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(store.name),
                  subtitle: Text(store.cnpj),
                ),
              );
            },
          );
        }
      },
    );
  }
}
