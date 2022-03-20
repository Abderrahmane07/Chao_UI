import 'package:flutter/material.dart';

void main() {
  runApp(const LoadingScreen());
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container());
  }
}







// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           Image(
//             image: AssetImage('assets/LogoBig.png'),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Chao',
//             style: TextStyle(fontSize: 64),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             'Make use of your unused time',
//             style: TextStyle(fontSize: 24),
//           ),
//         ],
//       ),
//     );
//   }
// }




// body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//                   IconButton(
//                     icon: Icon(Icons.extension),
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//               SizedBox(height: 40),
//               Text.rich(
//                 TextSpan(
//                     text: 'Welcome,',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                     children: [
//                       TextSpan(
//                           text: ' Abdellah',
//                           style: TextStyle(fontWeight: FontWeight.normal))
//                     ]),
//                 style: TextStyle(fontSize: 50),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(
//                     Icons.search,
//                     size: 20,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   hintText: 'Trissiane',
//                 ),
//               ),
//               SizedBox(
//                 height: 60,
//               ),
//               Text(
//                 'Places',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // GridView.count(
//               //   crossAxisCount: 2,
//               //   children: [],
//               // )
//             ],
//           )),




