import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/article.dart';
import '../services/remote_service.dart';

class ArticleView extends StatefulWidget {
  final List<bool> choice;
  const ArticleView({Key? key, required this.choice}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState(choice);
}

class _ArticleViewState extends State<ArticleView> {
  List<bool> choice;
  _ArticleViewState(this.choice);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            // return Text(article!.query.pages.the736.extract);
            return Html(
              data: article!.query.pages.pageId.extract,
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
