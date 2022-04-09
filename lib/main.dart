import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/our_font_size_provider.dart';
import 'package:tentative_chao_1/providers/our_theme_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentative_chao_1/views/article_view.dart';
import 'package:tentative_chao_1/views/choice_view.dart';
import 'package:tentative_chao_1/views/login_view.dart';
// import 'package:tentative_chao_1/views/time_view.dart';
import 'package:tentative_chao_1/views/welcome_view.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => OurTheme(),
      ),
      ChangeNotifierProvider(
        create: (_) => OurFontSize(),
      ),
    ],
    child: const LoadingScreen(),
  ));
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: (Provider.of<OurTheme>(context).isDark
          ? ThemeData.dark()
          : ThemeData.light()),
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
