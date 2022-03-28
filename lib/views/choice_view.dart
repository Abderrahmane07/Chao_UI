import 'package:flutter/material.dart';

class ChoiceView extends StatefulWidget {
  const ChoiceView({Key? key}) : super(key: key);

  @override
  State<ChoiceView> createState() => _ChoiceViewState();
}

class _ChoiceViewState extends State<ChoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Image(
              image: AssetImage('assets/Femme.png'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Select fields that you like reading about:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 250,
            child: ListView(
              children: [
                choiceButton(0),
                choiceButton(1),
                choiceButton(2),
                choiceButton(3),
                choiceButton(4),
                choiceButton(5),
                choiceButton(6),
                choiceButton(7),
                choiceButton(8),
                OutlinedButton(
                  onPressed: () {
                    debugPrint('ha gowa mcha l page a5ra');
                  },
                  child: const Text('Connecter'),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/time/',
              );
            },
            child: const Text(
              'Art',
              style: TextStyle(color: Colors.black),
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          // ToggleButtons(
          //   children: const [
          //     Text('coco'),
          //   ],
          //   isSelected: _selections,
          //   onPressed: (int index) {
          //     setState(() {
          //       _selections[index] = !_selections[index];
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  ToggleButtons choiceButton(int indice) {
    return ToggleButtons(
      children: [
        Text(domaines[indice]),
      ],
      isSelected: [activateds[indice]],
      onPressed: (int index) {
        setState(() {
          activateds[indice] = !activateds[indice];
        });
      },
    );
  }
}

const List<String> domaines = [
  "Astronomy",
  "Blockchain",
  "Mathematics",
  "Science",
  "History",
  "Medicine",
  "Art",
  "Sport",
  "Technology",
  "Biology",
  "Geography",
  "Finance",
  "Architecture"
];
List<bool> activateds = List.generate(13, (_) => false);
const Map<String, List<String>> links = {
  'Astronomy': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Bockchain': [
    'https://en.wikipedia.org/wiki/Blockchain',
    'https://en.wikipedia.org/wiki/Privacy_and_blockchain',
    'https://en.wikipedia.org/wiki/Cryptocurrency'
  ],
  'Mathematics': [
    'https://en.wikipedia.org/wiki/Number_theory',
    'https://en.wikipedia.org/wiki/Geometry',
    'https://en.wikipedia.org/wiki/Algebra'
  ],
  'Science': [
    'https://en.wikipedia.org/wiki/Science',
    'https://en.wikipedia.org/wiki/Research',
    'https://en.wikipedia.org/wiki/Outline_of_natural_science'
  ],
  'History': [
    'https://en.wikipedia.org/wiki/History',
    'https://en.wikipedia.org/wiki/World_War_II',
    'https://en.wikipedia.org/wiki/Hirohito'
  ],
  'Medicine': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Art': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Sport': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Technology': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Biology': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Geography': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Finance': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
  'Architecture': [
    'https://en.wikipedia.org/wiki/Constellation',
    'https://en.wikipedia.org/wiki/Cosmic_wind',
    'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
  ],
};
// List<bool> _selections = List.generate(1, (_) => false);

// import 'package:flutter/material.dart';

// class ChoiceView extends StatefulWidget {
//   const ChoiceView({Key? key}) : super(key: key);

//   @override
//   State<ChoiceView> createState() => _ChoiceViewState();
// }

// class _ChoiceViewState extends State<ChoiceView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Align(
//             alignment: Alignment.centerRight,
//             child: Image(
//               image: AssetImage('assets/Femme.png'),
//             ),
//           ),
//           const SizedBox(
//             height: 60,
//           ),
//           const Text(
//             'Select fields that you like reading about:',
//             style: TextStyle(fontSize: 18),
//           ),
//           SizedBox(
//             height: 250,
//             child: GridView.count(
//               crossAxisCount: 3,
//               children: [
//                 SizedBox(
//                   height: 20,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       debugPrint('ha gowa mcha l page a5ra');
//                     },
//                     child: const Text('Connecter'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       debugPrint('ha gowa mcha l page a5ra');
//                     },
//                     child: const Text('Connecter'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       debugPrint('ha gowa mcha l page a5ra');
//                     },
//                     child: const Text('Connecter'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       debugPrint('ha gowa mcha l page a5ra');
//                     },
//                     child: const Text('Connecter'),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       debugPrint('ha gowa mcha l page a5ra');
//                     },
//                     child: const Text('Connecter'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           OutlinedButton(
//             onPressed: () {
//               debugPrint('ha gowa mcha l page a5ra');
//             },
//             child: const Text(
//               'Art',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           // ignore: prefer_const_literals_to_create_immutables
//           ToggleButtons(
//             children: const [
//               Text('coco'),
//             ],
//             isSelected: _selections,
//             onPressed: (int index) {
//               setState(() {
//                 _selections[index] = !_selections[index];
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// List<bool> _selections = List.generate(1, (_) => false);
