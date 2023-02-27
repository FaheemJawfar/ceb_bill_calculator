import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_translations.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDefaults();
  runApp(const MyApp());
}


late String selectedLanguage;
late String langCode;
late String countryCode;


Future<void> loadDefaults() async {
  final prefs = await SharedPreferences.getInstance();
  selectedLanguage = prefs.getString('language') ?? 'English';
  langCode = prefs.getString('lang_code') ?? 'en';
  countryCode =  prefs.getString('country_code') ?? 'US';

  // print(selectedLanguage);
  // print(langCode);
  // print(countryCode);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static String fontFamily = 'NotoSans-$langCode';


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CEB - Bill Calculator',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Locale(langCode, countryCode),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: fontFamily,
        appBarTheme: const AppBarTheme(
            color: Colors.indigo,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(fontSize: 18))
      ),
      home: HomePage(selectedLanguage: selectedLanguage),
    );
  }
}

