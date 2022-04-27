import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/our_font_family.dart';
import 'package:tentative_chao_1/providers/our_font_size_provider.dart';
import 'package:tentative_chao_1/providers/our_line_spacing_provider.dart';
import 'package:tentative_chao_1/providers/our_theme_provider.dart';

import '../services/auth/auth_service.dart';

class SidebarView extends StatefulWidget {
  const SidebarView({Key? key}) : super(key: key);

  @override
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  bool isNoDisturbMode = false;
  // String font = 'Neuton';

  List<bool> _selections = [false, true, false];
//  List<bool> _selections = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    bool isDarkView = Provider.of<OurTheme>(context).isDark;
    int taille = Provider.of<OurFontSize>(context).ourFontSize;
    String font = Provider.of<OurFontFamily>(context).ourFontFamily;
    List<bool> listOfLineSpacing =
        Provider.of<OurLineSpacing>(context).ourLineList;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Welcome,'),
            accountEmail: const Text('Email.test@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Container(
                  color: Colors.black,
                  // child: const Text('T'),
                  height: 90,
                  width: 90,

                  // child: Image.network(
                  //   'https://img-19.commentcamarche.net/cI8qqj-finfDcmx6jMK6Vr-krEw=/1500x/smart/b829396acc244fd484c5ddcdcb2b08f3/ccmcms-commentcamarche/20494859.jpg',
                  // height: 90,
                  // width: 90,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black38,
              image: DecorationImage(
                  image: NetworkImage(
                    'https://sothebys-com.brightspotcdn.com/dims4/default/d7c7769/2147483647/strip/false/crop/640x360+0+0/resize/1200x675!/quality/90/?url=http%3A%2F%2Fsothebys-brightspot-migration.s3.amazonaws.com%2F1d%2Fc9%2F29%2F63fdd1edaa4c75d199965a7b1aabaac65843e8cc3c4a919d5d88db0af0%2Fdali-recirc.jpg',
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
                height: 10,
              ),
              ToggleButtons(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.density_small),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.density_medium),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.density_large),
                  ),
                ],
                isSelected: listOfLineSpacing,
                onPressed: (int index) {
                  setState(() {
                    bool temporary = listOfLineSpacing[index];
                    listOfLineSpacing = [false, false, false];
                    listOfLineSpacing[index] = !temporary;
                    Provider.of<OurLineSpacing>(context, listen: false)
                        .change(listOfLineSpacing);
                  });
                },
                renderBorder: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Icon(Icons.text_fields),
                    const SizedBox(
                      width: 70,
                    ),
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
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () async {
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                },
                child: const Text('Log Out'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Sign out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Log out'),
              ),
            ]);
      }).then((value) => value ?? false);
}
