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
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              //width: MediaQuery.of(context).size.width,
              height: 250,
              //width: 300,
              child: ListView(scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  children: [
                    Align(
                      child: choiceButton(0),
                    ),
                    Align(
                      child: choiceButton(1),
                    ),
                    Align(
                      child: choiceButton(2),
                    ),
                    Align(
                      child: choiceButton(3),
                    ),
                    Align(
                      child: choiceButton(4),
                    ),
                    Align(
                      child: choiceButton(5),
                    ),
                    Align(
                      child: choiceButton(6),
                    ),
                    Align(
                      child: choiceButton(7),
                    ),
                    Align(
                      child: choiceButton(8),
                    ),
                    Align(
                      child: choiceButton(9),
                    ),
                    Align(
                      child: choiceButton(10),
                    ),
                  ]),
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
              'Choose fields',
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
List<bool> activateds = List.generate(domaines.length, (_) => false);
