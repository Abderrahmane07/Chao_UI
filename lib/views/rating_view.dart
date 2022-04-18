import 'package:flutter/material.dart';

class RatingView extends StatefulWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  double speed = 0.0;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text('Speed'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('too slow'),
              Text('perfect'),
              Text('too fast'),
            ],
          ),
          Slider(
            value: speed,
            onChanged: (newSpeed) {
              setState(() {
                speed = newSpeed;
              });
            },
            min: -10.0,
            max: 10.0,
          ),
          SizedBox(
            height: 100,
          ),
          Text('Did you like the article?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.mood_bad),
              Slider(
                value: rating,
                onChanged: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
                min: 0,
                max: 5,
              ),
              Icon(Icons.mood),
            ],
          ),
        ],
      ),
    );
  }
}
