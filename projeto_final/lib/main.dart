import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_final/language_provider.dart';
import 'package:projeto_final/repositories/vehicle_repositorie.dart';
import 'package:projeto_final/store_list_provider.dart';
import 'package:projeto_final/theme_provider.dart';
import 'package:projeto_final/view/date_price_screen.dart';
import 'package:projeto_final/view/document_name_screen.dart';
import 'package:projeto_final/view/initial_screen.dart';
import 'package:projeto_final/view/model_brand_screen.dart';
import 'package:projeto_final/view/plate_screen.dart';
import 'package:projeto_final/view/price_purchase_date_screen.dart';
import 'package:projeto_final/view/settings_screen.dart';
import 'package:projeto_final/view/start_screen.dart';
import 'package:projeto_final/view/store_list_screen.dart';
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
  // ignore: unused_local_variable
  final database = await openDatabase(
    dbPath,
    onCreate: (db, version) {
      db.execute(TableStore.createTable);
    },
    version: 1,
  );
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
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkMode: false),
        ),
        ChangeNotifierProvider(
            create: (_) => StoreListProvider(StoreController())),
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
        "/login_page": (context) => const LoginPage(),
        "/register": (context) => RegisterScreen(),
        "/home": (context) => const HomeScreen(),
        "/model_brand": (context) => const ModelBrandScreen(),
        "/manufacture_plate": (context) => const ManufacturePlateScreen(),
        "/vehicle_year_photo": (context) => const VehicleYearPhotoScreen(),
        "/price_purchase": (context) => const PricePurchaseDateScreen(),
        "/initial": (context) => const Initial(),
        "/storeList": (context) => StoreList(),
        "/settings": (context) => const Settings(),
        "/document_name": (context) => DocumentName(),
        "/date_Price": (context) => const DatePrice(),
      },
    );
  }
}
