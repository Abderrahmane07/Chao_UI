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
  const ArticleView({Key? key, required this.choice, required this.time})
      : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState(choice, time);
}

int index = 0;

class _ArticleViewState extends State<ArticleView> {
  List<bool> choice;
  int time;
  _ArticleViewState(this.choice, this.time);
  final user = FirebaseAuth.instance.currentUser;

  //db.collection('users').doc(userCredential.user.uid)

  Article? article;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    article = await RemoteService().getArticle(choice);
    if (article != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection(
            'Users') //.where('user?.uid.articles.article[0].isread', isEqualTo: true)
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      try {
        dynamic dataonuser =
            documentSnapshot.get(FieldPath(['articles', 'article']));
        print(dataonuser[0]['isreadparts']);
      } on StateError catch (e) {
        print('No nested field exists!');
      }
      // if (documentSnapshot.exists) {
      //   final temporary = documentSnapshot.data();
      //   print(temporary['articles']);
      //   print(documentSnapshot.data());
      //   print('Document exists on the database');
      // }
    });
    //final data = snapshot.requireData;
    return Scaffold(
      drawer: const SidebarView(),
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            // final userCredential = FirebaseAuth.instance.currentUser?.uid;
            // return Text(article!.query.pages.the736.extract);
            String choosenArticle = article!.query.pages.pageId.extract;
            List<Paragraph> part =
                ArticleFunctions().decomposeToParagraphs(choosenArticle);
            //List<bool> temporary = ;
            String choosenPart =
                ArticleFunctions().timeToArticle(part, time)[0];
            int index = ArticleFunctions().timeToArticle(part, time)[1];
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
                    List<bool> listOfIsRead = List.filled(part.length, false);
                    for (int i = 0; i < index; i++) {
                      //part[i].isRead = true;
                      listOfIsRead[i] = true;

                      //print('$i');
                    }
                    bool isRead = ArticleFunctions().coco(listOfIsRead) == -1
                        ? true
                        : false;
                    print(index);
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user?.uid)
                        .update({
                      //'isdark': false,
                      'speed': 120,
                      //'fontsize': 14,
                      'articles': {
                        'article': [
                          {
                            'pageid': article!.query.pages.pageId.pageid,
                            'length': articleLength,
                            'isread': isRead,
                            'domaine': 'Random',
                            'isreadparts': listOfIsRead,
                            'title': article!.query.pages.pageId.title,
                          },
                          {
                            'pageid': 500,
                            'length': 3000,
                            'isread': true,
                            'domaine': 'Random',
                            'isreadparts': [false, false, false],
                            'title': 'Fooled',
                          }
                        ]
                      }
                    });

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
