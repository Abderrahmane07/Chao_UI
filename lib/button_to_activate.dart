import 'package:flutter/material.dart';

class ChoiceButton extends StatefulWidget {
  const ChoiceButton({Key? key}) : super(key: key);

  @override
  State<ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  ToggleButtons choiceButton(String domaine, bool activated) {
    return ToggleButtons(
      children: [
        Text(domaine),
      ],
      isSelected: [activated],
      onPressed: (int index) {
        setState(() {
          activated = !activated;
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
List<bool> activateds = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];


// class ButtonToActivate extends StatefulWidget{
//   String domaine;
//   bool activated;

//   ButtonToActivate(this.domaine, this.activated, {Key? key}) : super(key: key);

// }

//   @override
//   State<StatefulWidget> createState() {
//
//     throw UnimplementedError();
//   }
// }


