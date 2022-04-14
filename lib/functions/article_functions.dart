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
    while (wordsCount < 0.9 * words && index < listOfParagraphs.length) {
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

    while (truncatedArticle.contains(begOfParagraph)) {
      int indexOfBeg = truncatedArticle.indexOf(begOfParagraph);
      int indexOfEnd = truncatedArticle.indexOf(endOfParagraph);
      paragraph = truncatedArticle.substring(indexOfBeg, indexOfEnd + 4);
      truncatedArticle = truncatedArticle.substring(indexOfEnd + 4);

      part = Paragraph(
          text: paragraph, lengthOfParagraph: lengthOfPart(paragraph));
      listOfParagraphs += [part];
    }

    return listOfParagraphs;
  }

  // This function calculates the number of words in a text
  int lengthOfPart(String text) {
    return text.split(' ').length;
  }
}
