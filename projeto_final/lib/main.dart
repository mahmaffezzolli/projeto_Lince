import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_final/repositories/vehicle_repositorie.dart';
import 'package:projeto_final/view/model_brand_screen.dart';
import 'package:projeto_final/view/plate_screen.dart';
import 'package:projeto_final/view/price_purchase_date_screen.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final/storages/user_database.dart';
import 'package:projeto_final/view/home_screen.dart';
import 'package:projeto_final/view/login_page.dart';
import 'package:projeto_final/view/register_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databasesPath = await getDatabasesPath();
  final dbPath = join(databasesPath, 'register.db');
  // ignore: unused_local_variable
  final database = await openDatabase(
    dbPath,
    onCreate: (db, version) {
      db.execute(TableStore.createTable);
    },
    version: 1,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordVisibilityProvider>(
          create: (context) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider<PasswordVisibilityProviderRegister>(
          create: (context) => PasswordVisibilityProviderRegister(),
        ),
        ChangeNotifierProvider<ChangeNotifierProviderNavigation>(
          create: (context) => ChangeNotifierProviderNavigation(),
        ),
        Provider<StoreController>(
          create: (context) => StoreController(),
        ),
        ChangeNotifierProvider<VehicleProvider>(
          create: (context) => VehicleProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/model_brand",
      routes: {
        "/login_page": (context) => const LoginPage(),
        "/register": (context) => RegisterScreen(),
        "/home": (context) => const HomeScreen(),
        "/model_brand": (context) => const ModelBrandScreen(),
        "/manufacture_plate": (context) => const ManufacturePlateScreen(),
        "/price_purchase": (context) => const PricePurchaseDateScreen(),
        "/vehicle_year_photo": (context) => const PricePurchaseDateScreen(),
      },
    );
  }
}
