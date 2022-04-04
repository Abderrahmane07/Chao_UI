import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tentative_chao_1/models/part_to_read.dart';
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
            String choosenArticle = article!.query.pages.pageId.extract;
            List<PartToRead> part = decomposeToPartsToRead(choosenArticle);
            String choosenPart = timeToArticle(part, 10);
            int partLength = lengthOfPart(choosenPart);
            print('The part contains $partLength words');
            int articleLength = lengthOfPart(choosenArticle);
            print('The article contains $articleLength words');
            return Html(
              data: choosenPart,
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

  int lengthOfPart(String text) {
    return text.split(' ').length;
  }

  List<PartToRead> decomposeToPartsToRead(String article) {
    String begOfParagraph = '<p';
    String endOfParagraph = '</p>';
    String truncatedArticle = article;

    List<PartToRead> listOfParts = [];
    PartToRead part;
    String paragraph;

    while (truncatedArticle.contains(begOfParagraph)) {
      int indexOfBeg = truncatedArticle.indexOf(begOfParagraph);
      int indexOfEnd = truncatedArticle.indexOf(endOfParagraph);
      paragraph = truncatedArticle.substring(indexOfBeg, indexOfEnd + 4);
      truncatedArticle = truncatedArticle.substring(indexOfEnd + 4);

      part = PartToRead(text: paragraph, lengthOfPart: lengthOfPart(paragraph));
      listOfParts += [part];
    }

    return listOfParts;
  }

  String timeToArticle(List<PartToRead> listOfParts, int temps) {
    int speed =
        120; // Basic Speed of 120 words/minute, you'll find online that people can
    // read faster but it's not the case as we get easily distracted. So we take this as a base but we can change it later
    int words = speed * temps;
    int wordsCount = 0;
    String partToRead = '';
    int index = 0;
    while (wordsCount < 0.9 * words) {
      partToRead += listOfParts[index].text;
      wordsCount += listOfParts[index].lengthOfPart;

      index += 1;
    }

    return partToRead;
  }
}
