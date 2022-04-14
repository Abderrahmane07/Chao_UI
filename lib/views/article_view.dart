import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/models/paragraph.dart';
import 'package:tentative_chao_1/views/sidebar_view.dart';
import '../models/article.dart';
import '../providers/our_font_size_provider.dart';
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
    //CollectionReference articles =
    //   FirebaseFirestore.instance.collection('Articles');
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('Articles').snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something is not working');
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Text('Loading');
    //     }
    //     final data = snapshot.requireData;
    //     return Scaffold(
    //       body: ListView.builder(
    //           itemCount: data.size,
    //           itemBuilder: (context, index) {
    //             return Column(
    //               children: [
    //                 Text(
    //                   '${data.docs[index]['title']}',
    //                   style: TextStyle(fontSize: 25),
    //                 ),
    //                 Text(
    //                   '${data.docs[index]['extract']}',
    //                   style: TextStyle(fontSize: 16),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     articles.add({
    //                       'extract': article!.query.pages.pageId.extract,
    //                       'title': article!.query.pages.pageId.title,
    //                       'pageid': article!.query.pages.pageId.pageid,
    //                     });
    //                   },
    //                   child: Text('Coco'),
    //                 )
    //               ],
    //             );
    //           }),
    //     );
    //   },
    // );
    return Scaffold(
      drawer: const SidebarView(),
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            // return Text(article!.query.pages.the736.extract);
            String choosenArticle = article!.query.pages.pageId.extract;
            List<Paragraph> part =
                ArticleFunctions().decomposeToParagraphs(choosenArticle);
            String choosenPart =
                ArticleFunctions().timeToArticle(part, time)[0];
            int index = ArticleFunctions().timeToArticle(part, time)[1];
            int partLength = ArticleFunctions().lengthOfPart(choosenPart);
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
                    print(index);
                    for (int i = 0; i < index; i++) {
                      FirebaseFirestore.instance
                          .collection('PartToRead')
                          .add({});
                      part[i].isRead = true;
                      print(part[i].isRead);
                      print('$i');
                    }
                    print('Reading Done');
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
