import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/our_theme_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentative_chao_1/views/article_view.dart';
import 'package:tentative_chao_1/views/choice_view.dart';
import 'package:tentative_chao_1/views/login_view.dart';
// import 'package:tentative_chao_1/views/time_view.dart';
import 'package:tentative_chao_1/views/welcome_view.dart';

//bool darkMode = false;
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.getInstance().then((instance) {
  //   darkMode = instance.getBool('darkMode') ?? false;

  // });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => OurTheme(),
      ),
    ],
    child: const LoadingScreen(),
  ));
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
// context.read<OurTheme>().isDark
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: (Provider.of<OurTheme>(context).isDark
          ? ThemeData.dark()
          : ThemeData.light()),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   brightness: Brightness.dark,
      // ),
      routes: {
        '/': ((context) => const WelcomeView()),
        '/login/': ((context) => const LoginView()),
        '/choice/': ((context) => const ChoiceView()),
        // '/time/': ((context) => const TimeView()),
        // '/article/': ((context) => const ArticleView()),
      },
    );
  }
}
