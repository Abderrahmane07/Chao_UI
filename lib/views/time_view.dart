import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tentative_chao_1/views/article_from_title_view.dart';

import 'article_view.dart';

class TimeView extends StatefulWidget {
  final List<bool> choice;
  final String articleTitle;
  const TimeView({Key? key, required this.choice, required this.articleTitle})
      : super(key: key);

  @override
  State<TimeView> createState() => _TimeViewState(choice, articleTitle);
}

class _TimeViewState extends State<TimeView> {
  List<bool> choice;
  String articleTitle;
  _TimeViewState(this.choice, this.articleTitle);

  final List<int> choiceTime = List.generate(30, (index) => index + 1);
  var temps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Image(
              image: NetworkImage(
                  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgKrXT6kyg2lb_kn0EzOMaANdF2ICHlXogyyEf3w6tesFYqGfgof329nLO--QI0QALent0RPOxOMD-qbEzwsPDUmCC4IKrZRY8p5f5B8EZMyHRens9hiaIGgyGMALeHQv90S6DZnVAFTsjHtYZH_1RqO7qSepFVNcLQJjqSJ3xAUIvrZabNG7efJNhb/s16000/Homme_2.png'),
              //image: AssetImage('assets/Homme_2.png'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'How much time do you have?',
            style: TextStyle(fontSize: 18),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              scrollDirection: Axis.vertical,
              initialPage: 10,
            ),
            items: choiceTime.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  temps = i - 1;
                  return Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Center(
                      child: Text(
                        '$i Min',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          OutlinedButton(
            onPressed: () {
              if (articleTitle == '') {
                _sendDataToArticleView(context);
              } else {
                _sendDataToArticleFromTitleView(context);
              }

              // Navigator.of(context).pushNamed(
              //   '/article/',
              // );
            },
            child: const Text(
              'Go',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataToArticleView(BuildContext context) {
    List<bool> listToSend = choice;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleView(
            choice: listToSend,
            time: temps,
            articleTitle: '',
          ),
        ));
  }

  void _sendDataToArticleFromTitleView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleFromTitleView(
            choice: choice,
            time: temps,
            articleTitle: articleTitle,
          ),
        ));
  }
}
