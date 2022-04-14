import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/our_font_family.dart';
import 'package:tentative_chao_1/providers/our_font_size_provider.dart';
import 'package:tentative_chao_1/providers/our_theme_provider.dart';

class SidebarView extends StatefulWidget {
  const SidebarView({Key? key}) : super(key: key);

  @override
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  bool isNoDisturbMode = false;
  // String font = 'Neuton';

  List<bool> _selections = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    bool isDarkView = Provider.of<OurTheme>(context).isDark;
    int taille = Provider.of<OurFontSize>(context).ourFontSize;
    String font = Provider.of<OurFontFamily>(context).ourFontFamily;
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
              Row(
                children: [
                  Switch(
                    value: isDarkView,
                    onChanged: (value) {
                      Provider.of<OurTheme>(context, listen: false)
                          .change(value);
                      setState(() {
                        isDarkView = value;
                        print(isDarkView);
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Provider.of<OurFontFamily>(context, listen: false)
                            .previous();
                        setState(() {
                          if (font == 'Neuton') {
                            font = 'OpenSans';
                          }
                          if (font == 'Lato') {
                            font = 'Neuton';
                          }
                          if (font == 'OpenSans') {
                            font = 'Lato';
                          }
                        });
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    Text(font),
                    TextButton(
                      onPressed: () {
                        Provider.of<OurFontFamily>(context, listen: false)
                            .next();
                        setState(() {
                          if (font == 'Neuton') {
                            font = 'Lato';
                          }
                          if (font == 'Lato') {
                            font = 'OpenSans';
                          }
                          if (font == 'OpenSans') {
                            font = 'Neuton';
                          }
                        });
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ToggleButtons(
                children: const [
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Icon(Icons.text_fields),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Provider.of<OurFontSize>(context, listen: false)
                                .decrement();
                            setState(() {
                              taille--;
                            });
                          },
                          child: const Text('-'),
                        ),
                        Text('$taille'),
                        TextButton(
                          onPressed: () {
                            Provider.of<OurFontSize>(context, listen: false)
                                .increment();
                            setState(() {
                              taille++;
                            });
                          },
                          child: const Text('+'),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
