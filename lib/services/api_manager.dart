import 'dart:convert';
import 'package:http/http.dart';
import 'model.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<User>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}








// import 'package:http/http.dart' as http;

// class APIManager {
//   Future<void> getNews() async {
//     var client = http.Client();

//     var response = await client.get(Uri.https('newsapi.org',
//         'v2/everything?q=tesla&from=2022-02-20&sortBy=publishedAt&apiKey=33c977e4eeb843b194ad54bcaa7aba18'));
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//     }
//   }
// }
