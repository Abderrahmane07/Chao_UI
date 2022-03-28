import 'package:flutter/material.dart';
import 'package:tentative_chao_1/services/remote_service.dart';

import '../models/article.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // fetch datafrom API
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts![index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            posts![index].body ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}



// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Article> fetchArticle() async {
//   final response = await http.get(Uri.parse(
//       'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=Albert%20Einstein'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     debugPrint('code 200');
//     return Article.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     debugPrint('code 400');
//     throw Exception('Failed to load album');
//   }
// }

// // Exploitable response: https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=Albert%20Einstein

// class Article {
//   final String warnings;
//   final String batchComplete;
//   final String text;

//   Article(
//       {required this.warnings,
//       required this.batchComplete,
//       required this.text});

//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       warnings: json['batchcomplete'],
//       batchComplete: json['batchcomplete'],
//       text: json["query"]["pages"]["736"]["extract"],
//     );
//   }
// }

// class ArticleView extends StatefulWidget {
//   const ArticleView({Key? key}) : super(key: key);

//   @override
//   _ArticleViewState createState() => _ArticleViewState();
// }

// class _ArticleViewState extends State<ArticleView> {
//   late Future<Article> futureArticle;

//   @override
//   void initState() {
//     super.initState();
//     futureArticle = fetchArticle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Article>(
//             future: futureArticle,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(snapshot.data!.text),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 debugPrint('mn hna');
//                 debugPrint(snapshot.hasData.toString());
//                 debugPrint('hna fin kayna l erreur');
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';

// class ArticleView extends StatelessWidget {
//   const ArticleView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: const [
//           SizedBox(
//             height: 80,
//           ),
//           Text('a jma3'),
//         ],
//       ),
//     );
//   }
// }





// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:tentative_chao_1/services/api_manager.dart';
// import 'package:http/http.dart' as http;

// class ArticleView extends StatefulWidget {
//   const ArticleView({Key? key}) : super(key: key);

//   @override
//   State<ArticleView> createState() => _ArticleViewState();
// }

// class _ArticleViewState extends State<ArticleView> {
//   Future getNews() async {
//     var client = http.Client();

//     var response =
//         await client.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
//     var jsonData = jsonDecode(response.body);
//     List<User> users = [];
//     for (var u in jsonData) {
//       User user = User(u['name'], u['email'], u['userName']);
//       users.add(user);
//     }

//     return users;
//     // if (response.statusCode == 200) {
//     //   return response.body;
//     // } else {
//     //   return 'Error';
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Card(
//         child: FutureBuilder(
//             future: getNews(),
//             builder: (context, snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: const Center(
//                     child: Text('Loading'),
//                   ),
//                 );
//               } else {
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, i) {
//                       return ListTile(
//                         title: Text(snapshot.data[i].name),
//                         subtitle: Text(snapshot.data[i].userName),
//                         trailing: Text(snapshot.data[i].email),
//                       );
//                     });
//               }
//             }),
//       ),
//     );
//   }
// }

// class User {
//   final String name, email, userName;

//   User(this.name, this.email, this.userName);
// }







// Column(
      //   children: [
      //     const SizedBox(
      //       height: 40,
      //     ),
      //     const Text('dsd'),
      //     const SizedBox(
      //       height: 50,
      //     ),
      //     SingleChildScrollView(
      //       scrollDirection: Axis.vertical,
      //       child: FutureBuilder(
      //           future: getNews(),
      //           builder: ((context, snapshot) {
      //             if (snapshot.hasData) {
      //               return Text('Delivery done: ${snapshot.data}');
      //             } else if (snapshot.hasError) {
      //               return Text('Delivery error: ${snapshot.error.toString()}');
      //             } else {
      //               return const CircularProgressIndicator();
      //             }
      //           })),
      //     )
      //   ],
      // ),