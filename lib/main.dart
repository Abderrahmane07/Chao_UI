import 'package:flutter/material.dart';
import 'package:tentative_chao_1/views/article_view.dart';
import 'package:tentative_chao_1/views/choice_view.dart';
import 'package:tentative_chao_1/views/login_view.dart';
import 'package:tentative_chao_1/views/time_view.dart';
import 'package:tentative_chao_1/views/welcome_view.dart';

void main() {
  runApp(const LoadingScreen());
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': ((context) => const WelcomeView()),
        '/login/': ((context) => const LoginView()),
        '/choice/': ((context) => const ChoiceView()),
        '/time/': ((context) => const TimeView()),
        '/article/': ((context) => const ArticleView()),
      },
    );
  }
}
