import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import 'dart:math';

class RemoteService {
  Random random = Random();
  Future<Article?> getArticle(List<bool> testList) async {
    var client = http.Client();
    String finalOne = linkGenerator(testList);

    var uri = Uri.parse(finalOne);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return articleFromJson(json);
    } else {
      throw const Text('Error in RemoteService Class');
    }
  }

  String linkGenerator(List<bool> listinherited) {
    List<int> testListToInt = [];
    List<String> linksToString = links.keys.toList();
    for (var i = 0; i < listinherited.length; i++) {
      if (listinherited[i] == true) {
        testListToInt += [i];
      }
    }
    String domaine;
    if (testListToInt.isEmpty) {
      domaine = 'Random';
    } else {
      domaine =
          linksToString[testListToInt[random.nextInt(testListToInt.length)]];
    }
    List<String> list20 = links[domaine] ??
        [
          'https://en.wikipedia.org/wiki/Albert_Einstein',
          'https://en.wikipedia.org/wiki/Randomness',
          'https://en.wikipedia.org/wiki/Complexity',
        ];
    String wikiLink = list20[random.nextInt(list20.length)];
    String wikiModi = wikiLink.replaceRange(0, 30, "");
    String apiCallLink =
        'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=';
    String generalLink = apiCallLink + wikiModi;
    return generalLink.replaceAll('_', '%20');
  }
}

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
  'Random': [
    // it's this one that is used
    'https://en.wikipedia.org/wiki/Albert_Einstein',
    'https://en.wikipedia.org/wiki/Randomness',
    'https://en.wikipedia.org/wiki/Complexity',
  ],
};
