import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SidebarView extends StatefulWidget {
  const SidebarView({Key? key}) : super(key: key);

  @override
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  bool isDark = false;
  bool isNoDisturbMode = false;
  List<bool> _selections = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Trissiane'),
            accountEmail: const Text('Trissiane.Abdellah@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://img-19.commentcamarche.net/cI8qqj-finfDcmx6jMK6Vr-krEw=/1500x/smart/b829396acc244fd484c5ddcdcb2b08f3/ccmcms-commentcamarche/20494859.jpg',
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black38,
              image: DecorationImage(
                  image: NetworkImage(
                    'https://www.philomag.com/sites/default/files/styles/facebook/public/images/pmfr98entretienalain-berthozmarc-thirouin2.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              // const SizedBox(
              //   height: 100,
              // ),
              Row(
                children: [
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      setState(() {
                        isDark = value;
                        print(isDark);
                      });
                    },
                  ),
                  const Text("Dark mode"),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: isNoDisturbMode,
                    onChanged: (value) {
                      setState(() {
                        isNoDisturbMode = value;
                        print(isNoDisturbMode);
                      });
                    },
                  ),
                  const Text("Do not disturb mode"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items:
                    ['Neuton', 'Lato', 'Comic Sans', 'Open Dyslexic'].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.black12),
                        child: Center(
                          child: Text(
                            i,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 70,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ToggleButtons(
                children: [
                  Icon(Icons.local_airport),
                  Icon(Icons.face),
                  Icon(Icons.cabin),
                ],
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    bool temporary = _selections[index];
                    _selections = [false, false, false];
                    _selections[index] = !temporary;
                  });
                },
                renderBorder: false,
              )
            ],
          )
        ],
      ),
    );
  }
}
