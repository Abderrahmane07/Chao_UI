import 'package:http/http.dart' as http;

import '../models/article.dart';

class RemoteService {
  Future<Article?> getArticle() async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=Albert%20Einstein');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return articleFromJson(json);
    }
  }
}
