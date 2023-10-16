// ignore_for_file: unused_local_variable, unused_import, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_final/language_provider.dart';
import 'package:projeto_final/repositories/vehicle_repositorie.dart';
import 'package:projeto_final/storages/vehicle_database.dart';
import 'package:projeto_final/store_list_provider.dart';
import 'package:projeto_final/theme_provider.dart';
import 'package:projeto_final/view/document_name_screen.dart';
import 'package:projeto_final/view/initial_screen.dart';
import 'package:projeto_final/view/model_brand_screen.dart';
import 'package:projeto_final/view/plate_screen.dart';
import 'package:projeto_final/view/price_purchase_date_screen.dart';
import 'package:projeto_final/view/settings_screen.dart';
import 'package:projeto_final/view/start_screen.dart';
import 'package:projeto_final/view/store_list_screen.dart';
import 'package:projeto_final/view/vehicle_list_screen.dart';
import 'package:projeto_final/vehicle_list_provider.dart';
import 'package:projeto_final/view/vehicle_year_photo_screen.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final/storages/user_database.dart';
import 'package:projeto_final/view/home_screen.dart';
import 'package:projeto_final/view/login_page.dart';
import 'package:projeto_final/view/register_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databasesPath = await getDatabasesPath();
  final dbPath = join(databasesPath, 'register.db');
  final database = await openDatabase(
    dbPath,
    onCreate: (db, version) {
      db.execute(TableStore.createTable);
      db.execute(TableVehicle.createTable);
    },
    version: 2,
  );

  final vehicleDatabase = VehicleController();
  final userDatabase = StoreController();

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
        ChangeNotifierProvider(create: (_) => VehicleListProvider(VehicleController())),

        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkMode: false),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreListProvider(StoreController()),
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: "/home",
      routes: {
        "/start": (context) => const Start(),
        "/login_page": (context) => const LoginPage(), //problems
        "/register": (context) => RegisterScreen(), //correct
        "/home": (context) => const HomeScreen(),//correct
        "/model_brand": (context) =>   ModelBrandScreen(), //correct
        "/manufacture_plate": (context) => const ManufacturePlateScreen(),//correct
        "/vehicle_year_photo": (context) => const VehicleYearPhotoScreen(), //correct
        "/price_purchase": (context) =>  PricePurchaseDateScreen(), //problems
        "/initial": (context) => const Initial(), //correct
        "/storeList": (context) => const StoreList(),//correct
        "/settings": (context) => const Settings(),//correct
        "/document_name": (context) => const DocumentNameAndDatePriceScreen(),//correct
        "/vehicle_list": (context) => const VehicleListScreen(), //correct
        "/plate": (context) => const ManufacturePlateScreen(),
      },
    );
  }
}
