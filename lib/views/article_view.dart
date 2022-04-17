// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/models/paragraph.dart';
import 'package:tentative_chao_1/views/sidebar_view.dart';
import '../models/article.dart';
import '../providers/our_font_size_provider.dart';
import '../services/auth/auth_service.dart';
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

class _ArticleViewState extends State<ArticleView> {
  List<bool> choice;
  int time;
  _ArticleViewState(this.choice, this.time, this.articleTitle);
  final user = FirebaseAuth.instance.currentUser;

  //db.collection('users').doc(userCredential.user.uid)

  Article? article;
  var isLoaded = false;
  var dataOnArticles = [];
  String articleTitle;
  var isNew;
  var indexOfArticleInList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    article = await RemoteService().getArticle(choice);
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
        print(dataOnUser['articles']['nbofcompletedarticles']);

        dataOnArticles =
            documentSnapshot.get(FieldPath(['articles', 'article']));
        print(dataOnArticles);
        if (dataOnArticles != null) {
          for (int i = 0; i < dataOnArticles.length; i++) {
            if (dataOnArticles[i]['title'] == articleTitle &&
                !dataOnArticles[i]['isread']) {
              isNew = false;
              indexOfArticleInList = i;
            }
          }
        }

        //print(dataOnArticles[indexOfArticleInList]);
        print(isNew);
        //print(dataOnUser[1]['isreadparts']);
        //print(dataOnUser);
      } on StateError catch (e) {
        // FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
        //   'articles': {
        //     'nbofcompletedarticles': 0,
        //     'article': [
        //       {
        //         'pageid': article!.query.pages.pageId.pageid,
        //         'domaine': 'Random',
        //         'numberofreadparagraphs': 0,
        //       },
        //     ]
        //   }
        // });
        //dataOnArticles = [{}];
        print('No nested field exists!');
        //getData();
      }
      // if (documentSnapshot.exists) {
      //   final temporary = documentSnapshot.data();
      //   print(temporary['articles']);
      //   print(documentSnapshot.data());
      //   print('Document exists on the database');
      // }
    });
    if (article != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final data = snapshot.requireData;
    return Scaffold(
      drawer: const SidebarView(),
      appBar: AppBar(
        title: Text(articleTitle),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            //print('ici $dataOnArticles');
            //print(List<bool>.from(dataOnUser[2]['isreadparts']).runtimeType);
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

            // final userCredential = FirebaseAuth.instance.currentUser?.uid;
            // return Text(article!.query.pages.the736.extract);

            String choosenPart =
                ArticleFunctions().timeToArticle(part, time)[0];
            indexOfLastParagraph =
                ArticleFunctions().timeToArticle(part, time)[1];
            int partLength = ArticleFunctions().lengthOfPart(choosenPart);
            print(user?.uid);
            print('The part contains $partLength words');
            int articleLength = ArticleFunctions().lengthOfPart(choosenArticle);
            print('The article contains $articleLength words');
            return Column(
              children: [
                Html(
                  data: choosenPart,
                  style: {
                    'p': Style(
                      fontSize: FontSize(
                          (Provider.of<OurFontSize>(context).ourFontSize)
                              .toDouble()),
                    )
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
                        'domaine': 'Random',
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
                      // print(dataOnArticles);
                      dataOnArticles.add(
                        {
                          'pageid': article!.query.pages.pageId.pageid,
                          'length': articleLength,
                          'isread': isRead,
                          'domaine': 'Random',
                          'isreadparts': listOfIsRead,
                          'numberofreadparagraphs': 0,
                          'title': articleTitle,
                        },
                      );
                      // print(dataOnArticles);
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user?.uid)
                          .update({
                        // 'speed': 120,
                        'articles': {
                          'nbofcompletedarticles': 0,
                          'article': FieldValue.arrayUnion(dataOnArticles)
                        }
                      });
                    }
                    //print('Reading Done');
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
