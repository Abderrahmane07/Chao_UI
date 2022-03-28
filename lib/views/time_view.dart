import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TimeView extends StatefulWidget {
  const TimeView({Key? key}) : super(key: key);

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  final List<int> choiceTime = List.generate(30, (index) => index + 1);
  var temps;
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
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/Homme_2.png'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'How much time do you have?',
            style: TextStyle(fontSize: 18),
          ),
          // const SizedBox(
          //   height: 250,
          // ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              scrollDirection: Axis.vertical,
              initialPage: 10,
            ),
            items: choiceTime.map((i) {
              // temps = i;
              return Builder(
                builder: (BuildContext context) {
                  temps = i - 1;
                  return Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Center(
                      child: Text(
                        'text $i',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          OutlinedButton(
            onPressed: () {
              print("la valeur qu'on a eu est : $temps");

              Navigator.of(context).pushNamed(
                '/article/',
              );
              // Navigator.of(context).pushNamed(
              //   '/login/',);
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
}
