import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/google_sign_in.dart';
import 'package:tentative_chao_1/providers/our_font_family.dart';
import 'package:tentative_chao_1/providers/our_font_size_provider.dart';
import 'package:tentative_chao_1/providers/our_line_spacing_provider.dart';
import 'package:tentative_chao_1/providers/our_theme_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tentative_chao_1/views/article_view.dart';
import 'package:tentative_chao_1/views/choice_view.dart';
import 'package:tentative_chao_1/views/login_view.dart';
import 'package:tentative_chao_1/views/register_view.dart';
import 'package:tentative_chao_1/views/root_view.dart';
import 'package:tentative_chao_1/views/title_view.dart';
import 'package:tentative_chao_1/views/verify_email_view.dart';
// import 'package:tentative_chao_1/views/time_view.dart';
import 'package:tentative_chao_1/views/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => OurTheme(),
      ),
      ChangeNotifierProvider(
        create: (_) => OurFontSize(),
      ),
      ChangeNotifierProvider(
        create: (_) => OurFontFamily(),
      ),
      ChangeNotifierProvider(
        create: (_) => OurLineSpacing(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoogleSignInProvider(),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Provider.of<OurFontFamily>(context).ourFontFamily,
      ),
      darkTheme: (Provider.of<OurTheme>(context).isDark
          ? ThemeData.dark()
          : ThemeData.light()),
      themeMode: (Provider.of<OurTheme>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light),
      routes: {
        '/': ((context) => const WelcomeView()),
        '/root/': ((context) => const RootView()),
        '/login/': ((context) => const LoginView()),
        '/choice/': ((context) => const ChoiceView()),
        '/register/': ((context) => const RegisterView()),
        '/verify/': ((context) => const VerifyEmailView()),
        '/title/': ((context) => const TitleView()),
        // '/time/': ((context) => const TimeView()),
        // '/article/': ((context) => const ArticleView()),
      },
    );
  }
}
