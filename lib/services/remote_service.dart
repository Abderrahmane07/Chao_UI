import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tentative_chao_1/enums/domaine.dart';

import '../models/article.dart';
import 'dart:math';

import '../models/category.dart';

class RemoteService {
  Random random = Random();
  var client = http.Client();

  Future<List> getArticle(List<bool> inheritedList) async {
    List titleAndDomaine = await titlePicker(inheritedList);
    String title = titleAndDomaine[0];
    String domaine = titleAndDomaine[1];

    String finalCallLink = linkGenerator(title);

    var uri = Uri.parse(finalCallLink);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return [articleFromJson(json), domaine];
    } else {
      throw const Text('Error in RemoteService Class');
    }
  }

  Future<List> categorySelector(List<bool> inheritedList) async {
    // var client = http.Client();
    List<int> testListToInt = [];
    for (var i = 0; i < inheritedList.length; i++) {
      if (inheritedList[i] == true) {
        testListToInt += [i];
      }
    }

    String domaine;
    if (testListToInt.isEmpty) {
      domaine = domaines[random.nextInt(domaines.length)];
    } else {
      domaine = domaines[testListToInt[random.nextInt(testListToInt.length)]];
    }
    String url =
        'https://en.wikipedia.org/w/api.php?format=json&action=query&list=categorymembers&cmtitle=Category:$domaine&cmlimit=max&cmnamespace=14&from';
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return [categoryFromJson(json), domaine];
    } else {
      throw const Text('Error in RemoteService Class - categorySelector');
    }
  }

  Future<List> titlePicker(List<bool> inheritedList) async {
    List result = await categorySelector(inheritedList);
    Category selectedCategory = result[0];
    String domaine = result[1];
    String selectedSubCategory;
    do {
      result = await categorySelector(inheritedList);
      selectedCategory = result[0];
      domaine = result[1];
      selectedSubCategory = (selectedCategory.query.categorymembers)[
              random.nextInt((selectedCategory.query.categorymembers).length)]
          .title;
    } while ((selectedCategory.query.categorymembers).isEmpty);

    // List selectedCategories = (selectedSubCategory.query.categorymembers)[0].title;
    String url =
        'https://en.wikipedia.org/w/api.php?format=json&action=query&list=categorymembers&cmtitle=$selectedSubCategory&cmlimit=max&cmnamespace=0';
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    Category jsonOfSubCategory;
    if (response.statusCode == 200) {
      var json = response.body;
      jsonOfSubCategory = categoryFromJson(json);
    } else {
      throw const Text('Error in RemoteService Class - titlePicker');
    }
    String selectedTitle = (jsonOfSubCategory.query.categorymembers)[
            random.nextInt((jsonOfSubCategory.query.categorymembers).length)]
        .title;
    return [selectedTitle, domaine];
  }

  String linkGenerator(String givenTitle) {
    // This to take a link and give the title
    // String wikiModi = wikiLink.replaceRange(0, 30, "");
    givenTitle.replaceAll(' ', '%20');

    String generalLink =
        'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=$givenTitle';
    return generalLink.replaceAll('_', '%20');
  }

// This function takes the list of booleens that determine the preferences of the user
// and gives back in return a ready to use link for the API call, after trimming the link
// from the web and replacing '_' with '%20' even if the API apparently supports also
// the first one, after this we add in the beggining the root String needed to make the API call
// for the English Wikipedia, we may need to change this in the future
  // List<String> linkGenerator(List<bool> listinherited) {
  //   List<int> testListToInt = [];
  //   List<String> linksToString = links.keys.toList();
  //   for (var i = 0; i < listinherited.length; i++) {
  //     if (listinherited[i] == true) {
  //       testListToInt += [i];
  //     }
  //   }
  //   String domaine;
  //   if (testListToInt.isEmpty) {
  //     domaine = 'Random';
  //   } else {
  //     domaine =
  //         linksToString[testListToInt[random.nextInt(testListToInt.length)]];
  //   }
  //   List<String> list20 = links[domaine] ??
  //       [
  //         'https://en.wikipedia.org/wiki/Albert_Einstein',
  //         'https://en.wikipedia.org/wiki/Randomness',
  //         'https://en.wikipedia.org/wiki/Complexity',
  //       ];

  //   String wikiLink = list20[random.nextInt(list20.length)];
  //   String wikiModi = wikiLink.replaceRange(0, 30, "");
  //   String apiCallLink =
  //       'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=';
  //   String generalLink = apiCallLink + wikiModi;
  //   return [generalLink.replaceAll('_', '%20'), domaine];
  // }
}

// const Map<String, List<String>> links = {
//   'Astronomy': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Bockchain': [
//     'https://en.wikipedia.org/wiki/Blockchain',
//     'https://en.wikipedia.org/wiki/Privacy_and_blockchain',
//     'https://en.wikipedia.org/wiki/Cryptocurrency'
//   ],
//   'Mathematics': [
//     'https://en.wikipedia.org/wiki/Number_theory',
//     'https://en.wikipedia.org/wiki/Geometry',
//     'https://en.wikipedia.org/wiki/Algebra'
//   ],
//   'Science': [
//     'https://en.wikipedia.org/wiki/Science',
//     'https://en.wikipedia.org/wiki/Research',
//     'https://en.wikipedia.org/wiki/Outline_of_natural_science'
//   ],
//   'History': [
//     'https://en.wikipedia.org/wiki/History',
//     'https://en.wikipedia.org/wiki/World_War_II',
//     'https://en.wikipedia.org/wiki/Hirohito'
//   ],
//   // 'Religion': [
//   //   'https://en.wikipedia.org/wiki/Wahhabism',
//   //   'https://en.wikipedia.org/wiki/Wahhabism',
//   //   'https://en.wikipedia.org/wiki/Wahhabism'
//   // ],
//   'Medicine': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Art': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Sport': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Technology': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Biology': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Geography': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Finance': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Architecture': [
//     'https://en.wikipedia.org/wiki/Constellation',
//     'https://en.wikipedia.org/wiki/Cosmic_wind',
//     'https://en.wikipedia.org/wiki/Milky_Way_(mythology)'
//   ],
//   'Random': [
//     // it's this one that is used
//     'https://en.wikipedia.org/wiki/Albert_Einstein',
//     'https://en.wikipedia.org/wiki/Randomness',
//     'https://en.wikipedia.org/wiki/Complexity',
//   ],
// };
