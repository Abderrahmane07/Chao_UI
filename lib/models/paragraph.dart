class Paragraph {
  bool isRead = false;
  String text;
  int lengthOfParagraph;

  String? fatherArticle;
  String? section;

  Paragraph({
    required this.text,
    required this.lengthOfParagraph,
  });
}
