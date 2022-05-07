import 'package:flutter/material.dart';
import 'package:tentative_chao_1/views/time_view.dart';

import '../enums/domaine.dart';

class TitleView extends StatefulWidget {
  const TitleView({Key? key}) : super(key: key);

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  late final TextEditingController _articleTitle;

  @override
  void initState() {
    _articleTitle = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _articleTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Image(
              image: NetworkImage(
                  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi0uOAsc-Ughjqx0qoKU9XnadcegGFVcPOxSATV4m__Ib6AXpaT48cQBBtzU9xDy34hoZdU4taK-LH1oZSWNoyry9FRYN9fc-nahjV2NeB16CM_JDqm_1W-8f_A4rkbrCGsUoK4ZLDQGtyPxqylWQsgYeU8elGwGRKheNl2y1syv6JOxLMZDyHkFl0u/s16000/Homme_1.png'),
              // image: AssetImage('assets/Homme_1.png'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _articleTitle,
              //enableSuggestions: false,
              autocorrect: false,
              //keyboardType: TextInputType.articleTitleAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type the title of the article you want',
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          OutlinedButton(
            onPressed: () {
              final articleTitle = _articleTitle.text;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeView(
                      choice: activateds,
                      articleTitle: articleTitle,
                    ),
                  ));
            },
            child: const Text('Proceed'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/choice/', (route) => false);
            },
            child: const Text("Want to read an article just randomly?"),
          ),
        ],
      ),
    );
  }
}

List<bool> activateds = List.generate(domaines.length, (_) => false);
