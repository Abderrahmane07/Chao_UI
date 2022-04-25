// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/models/paragraph.dart';
// import 'package:tentative_chao_1/views/rating_view.dart';
import 'package:tentative_chao_1/views/sidebar_view.dart';
import '../models/article.dart';
import '../providers/our_font_size_provider.dart';
import '../services/remote_service.dart';
import 'package:tentative_chao_1/functions/article_functions.dart';

class ArticleView extends StatefulWidget {
  final List<bool> choice;

  final int time;
  final String articleTitle;
  const ArticleView(
      {Key? key,
      required this.choice,
      required this.time,
      required this.articleTitle})
      : super(key: key);

  @override
  State<ArticleView> createState() =>
      _ArticleViewState(choice, time, articleTitle);
}

int indexOfLastParagraph = 0;
double rating = 0.0;

class _ArticleViewState extends State<ArticleView> {
  List<bool> choice;
  int time;
  _ArticleViewState(this.choice, this.time, this.articleTitle);
  final user = FirebaseAuth.instance.currentUser;

  Article? article;
  var isLoaded = false;
  var dataOnArticles = [];
  String articleTitle;
  var isNew;
  var indexOfArticleInList;
  var domaine;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List result = await RemoteService().getArticle(choice);
    article = result[0];
    domaine = result[1];
    articleTitle = article!.query.pages.pageId.title;
    isNew = true;

    await FirebaseFirestore.instance
        .collection(
            'Users') //.where('user?.uid.articles.article[0].isread', isEqualTo: true)
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      try {
        // This part to access a certain element in the whole user Map given back in response
        var dataOnUser = documentSnapshot.data()! as Map<String, dynamic>;

        dataOnArticles =
            documentSnapshot.get(FieldPath(['articles', 'article']));
        //print(dataOnArticles);
        if (dataOnArticles != null) {
          for (int i = 0; i < dataOnArticles.length; i++) {
            if (dataOnArticles[i]['title'] == articleTitle &&
                !dataOnArticles[i]['isread']) {
              isNew = false;
              indexOfArticleInList = i;
            }
          }
        }
        print('This article is new? $isNew');
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    if (article != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarView(),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(articleTitle),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            List<Paragraph> part;
            String choosenArticle;
            int toStartFrom = 0;
            if (!isNew) {
              toStartFrom = ArticleFunctions().coco(List<bool>.from(
                  dataOnArticles[indexOfArticleInList]['isreadparts']));
              choosenArticle = article!.query.pages.pageId.extract;
              List<Paragraph> originalPart =
                  ArticleFunctions().decomposeToParagraphs(choosenArticle);
              part = originalPart
                  .getRange(toStartFrom, originalPart.length)
                  .toList();
            } else {
              choosenArticle = article!.query.pages.pageId.extract;
              part = ArticleFunctions().decomposeToParagraphs(choosenArticle);
            }

            String choosenPart =
                ArticleFunctions().timeToArticle(part, time)[0];
            indexOfLastParagraph =
                ArticleFunctions().timeToArticle(part, time)[1];
            int partLength = ArticleFunctions().lengthOfPart(choosenPart);
            print(user?.uid);
            print('The part contains $partLength words');
            int articleLength = ArticleFunctions().lengthOfPart(choosenArticle);
            print('The article contains $articleLength words');
            double taille =
                (Provider.of<OurFontSize>(context).ourFontSize).toDouble();
            return Column(
              children: [
                //Html(data: choosenArticle),
                Html(
                  data: choosenPart,
                  style: {
                    'h1': Style(
                      fontSize: FontSize(
                        taille + 12,
                      ),
                    ),
                    'h2': Style(
                      fontSize: FontSize(
                        taille + 9,
                      ),
                    ),
                    'h3': Style(
                      fontSize: FontSize(
                        taille + 6,
                      ),
                    ),
                    'h4': Style(
                      fontSize: FontSize(
                        taille + 3,
                      ),
                    ),
                    'p': Style(
                      fontSize: FontSize(
                        taille,
                      ),
                    ),
                  },
                ),
                OutlinedButton(
                  onPressed: () {
                    List<bool> listOfIsRead;
                    if (!isNew) {
                      listOfIsRead = List<bool>.from(
                          dataOnArticles[indexOfArticleInList]['isreadparts']);
                      for (int i = toStartFrom;
                          i < toStartFrom + indexOfLastParagraph;
                          i++) {
                        listOfIsRead[i] = true;
                      }
                    } else {
                      listOfIsRead = List.filled(part.length, false);
                      for (int i = 0; i < indexOfLastParagraph; i++) {
                        listOfIsRead[i] = true;
                      }
                    }

                    bool isRead = ArticleFunctions().coco(listOfIsRead) == -1
                        ? true
                        : false;
                    print(indexOfLastParagraph);
                    if (!isNew) {
                      dataOnArticles[indexOfArticleInList] = {
                        'pageid': article!.query.pages.pageId.pageid,
                        'length': articleLength,
                        'isread': isRead,
                        'domaine': domaine,
                        'isreadparts': listOfIsRead,
                        'numberofreadparagraphs': 0,
                        'title': articleTitle,
                      };
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user?.uid)
                          .update({
                        'articles': {
                          'nbofcompletedarticles': 0,
                          'article': dataOnArticles
                        }
                      });
                    } else {
                      dataOnArticles.add(
                        {
                          'pageid': article!.query.pages.pageId.pageid,
                          'length': articleLength,
                          'isread': isRead,
                          'domaine': domaine,
                          'isreadparts': listOfIsRead,
                          'numberofreadparagraphs': 0,
                          'title': articleTitle,
                        },
                      );
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user?.uid)
                          .update({
                        'articles': {
                          'nbofcompletedarticles': 0,
                          'article': FieldValue.arrayUnion(dataOnArticles)
                        }
                      });
                    }
                  },
                  child: const Text(
                    'Done Reading',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
          itemCount: 1,
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// This part is inside the button we moved it here to test the pop up button that
// will allow us to verify the reading and give a rating for the suggestion and the speed









// 1
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => RatingView(),
                  //       ));
                  // },
                  // child: const Text(
                  //   'Done Reading',
                  //   style: TextStyle(color: Colors.black),
                  // ),

                    // 2
                    // showModalBottomSheet<void>(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return Container(
                    //         height: 400,
                    //         color: Colors.white,
                    //         child: Column(children: [
                    //           Text('Speed'),
                    //           Slider(
                    //             value: rating,
                    //             onChanged: (newRating) {
                    //               setState(() {
                    //                 rating = newRating;
                    //               });
                    //             },
                    //             min: -10.0,
                    //             max: 10.0,
                    //             divisions: 20,
                    //           )
                    //         ]),
                    // child: Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: <Widget>[
                    //       const Text('Modal BottomSheet'),
                    //       ElevatedButton(
                    //         child: const Text('Close BottomSheet'),
                    //         onPressed: () => Navigator.pop(context),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    //   );
                    // });