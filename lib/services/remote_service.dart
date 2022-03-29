import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import 'dart:math';

class RemoteService {
  Random random = Random();
  Future<Article?> getArticle() async {
    var client = http.Client();
    List<String> testList = ['Blockchain', 'Algebra', 'Science'];
    String generalLink =
        'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=' +
            testList[random.nextInt(3)];

    var uri = Uri.parse(generalLink);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return articleFromJson(json);
    } else {
      throw const Text('Error in RemoteService Class');
    }
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
};
