import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/models/part_to_read.dart';
import 'package:tentative_chao_1/views/sidebar_view.dart';
import '../models/article.dart';
import '../providers/our_font_size_provider.dart';
import '../services/remote_service.dart';

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
            List<PartToRead> part = decomposeToPartsToRead(choosenArticle);
            String choosenPart = timeToArticle(part, time)[0];
            int index = timeToArticle(part, time)[1];
            int partLength = lengthOfPart(choosenPart);
            print('The part contains $partLength words');
            int articleLength = lengthOfPart(choosenArticle);
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

  List timeToArticle(List<PartToRead> listOfParts, int temps) {
    int speed =
        120; // Basic Speed of 120 words/minute, you'll find online that people can
    // read faster but it's not the case as we get easily distracted. So we take this as a base but we can change it later
    int words = speed * temps;
    int wordsCount = 0;
    String partToRead = '';
    index = 0;
    while (wordsCount < 0.9 * words) {
      if (!listOfParts[index].isRead) {
        partToRead += listOfParts[index].text;
        wordsCount += listOfParts[index].lengthOfPart;
      }
      index += 1;
    }

    return [partToRead, index];
  }
}
