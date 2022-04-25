import '../models/paragraph.dart';

class ArticleFunctions {
  // This function takes a list of paragraphs and an integer
  List timeToArticle(List<Paragraph> listOfParagraphs, int temps) {
    int speed =
        120; // Basic Speed of 120 words/minute, you'll find online that people can
    // read faster but it's not the case as we get easily distracted. So we take this as a base but we can change it later
    int words = speed * temps;
    int wordsCount = 0;
    String partToRead = '';
    int index = 0;
    while (wordsCount < words && index < listOfParagraphs.length) {
      if (!listOfParagraphs[index].isRead) {
        partToRead += listOfParagraphs[index].text;
        wordsCount += listOfParagraphs[index].lengthOfParagraph;
      }
      index += 1;
    }

    return [partToRead, index];
  }

  // This function takes a string which contains the extract from the article, then it
  //decomposes it to paragraphs based on the delimiters from html '<p>' and '</p>'. In the end
  //it returns a list of the defined element paragraph in the class Paragraph
  List<Paragraph> decomposeToParagraphs(String article) {
    String begOfParagraph = '<p';
    String endOfParagraph = '</p>';
    String truncatedArticle = article;

    List<Paragraph> listOfParagraphs = [];
    Paragraph part;
    String paragraph;

    int indexOfEnd;
    while (truncatedArticle.contains(begOfParagraph)) {
      indexOfEnd = truncatedArticle.indexOf(endOfParagraph);
      paragraph = truncatedArticle.substring(0, indexOfEnd + 4);
      truncatedArticle = truncatedArticle.substring(indexOfEnd + 4);

      part = Paragraph(
          text: paragraph, lengthOfParagraph: lengthOfPart(paragraph));
      listOfParagraphs += [part];
    }

    return listOfParagraphs;
  }

// This function return an integer according to the list of booleens it is given;
// if it's fully containing true then it return -1, if it contains falses from a
// certain position it returns its index
  int coco(List<bool> listToSee) {
    int index = 0;
    for (int i = 0; i < listToSee.length; i++) {
      if (listToSee[i]) {
        index++;
      }
    }
    if (index == listToSee.length) {
      return -1;
    } else {
      return index;
    }
  }

  // This function calculates the number of words in a text
  int lengthOfPart(String text) {
    return text.split(' ').length;
  }
}
