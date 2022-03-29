import 'package:flutter/material.dart';
import 'package:tentative_chao_1/views/time_view.dart';

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
              _sendDataToSecondScreen(context);
              // Navigator.of(context).pushNamed(
              //   '/time/',
              // );
            },
            child: const Text(
              'Art',
              style: TextStyle(color: Colors.black),
            ),
          ),
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

  void _sendDataToSecondScreen(BuildContext context) {
    List<bool> listToSend = activateds;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeView(
            choice: listToSend,
          ),
        ));
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
