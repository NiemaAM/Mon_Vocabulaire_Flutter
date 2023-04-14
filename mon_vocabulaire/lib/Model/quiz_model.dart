import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class QuizModel {
  List<dynamic> propositions = ["sons.mp3", "image.png", "article", "mot"];
  List<dynamic> propositionsImages = [
    "sons.mp3",
    "image.png",
    "article",
    "mot"
  ];
  List<dynamic> reponse = ["sons.mp3", "image.png", "article", "mot"];

  Future<void> getRandomWords(String theme, String subtheme) async {
    // Load the JSON data from the asset file
    String jsonStr = await rootBundle.loadString('assets/data.json');

    // Parse the JSON string to a map
    Map<String, dynamic> jsonMap = json.decode(jsonStr);

    // Get the map of elements
    Map<String, dynamic> elementsMap = jsonMap[theme][subtheme];

    // Get a list of the 'mot' values from the elements map
    List<dynamic> motList =
        elementsMap.values.map((valueMap) => valueMap['mot']).toList();

    // Get a list of the 'article' values from the elements map
    List<dynamic> articleList =
        elementsMap.values.map((valueMap) => valueMap['article']).toList();

    // Get a list of the 'code' values from the elements map
    List<dynamic> codeList =
        elementsMap.values.map((valueMap) => valueMap['code']).toList();

    Random random = Random();
    Set<int> randomNumbers = {};
    while (randomNumbers.length < 4) {
      randomNumbers.add(random.nextInt(motList.length));
    }
    List<int> randomNumberList = randomNumbers.toList();
    int randomNumber1 = randomNumberList[0];
    int randomNumber2 = randomNumberList[1];
    int randomNumber3 = randomNumberList[2];
    int randomNumber4 = randomNumberList[3];

    propositions[0] = motList[randomNumber1];
    propositions[1] = motList[randomNumber2];
    propositions[2] = motList[randomNumber3];
    propositions[3] = motList[randomNumber4];
    List<int> code = [
      codeList[randomNumber1],
      codeList[randomNumber2],
      codeList[randomNumber3],
      codeList[randomNumber4]
    ];
    List<String> articles = [
      articleList[randomNumber1],
      articleList[randomNumber2],
      articleList[randomNumber3],
      articleList[randomNumber4]
    ];
    propositionsImages[0] = "assets/images/${code[0]}.png";
    propositionsImages[1] = "assets/images/${code[1]}.png";
    propositionsImages[2] = "assets/images/${code[2]}.png";
    propositionsImages[3] = "assets/images/${code[3]}.png";

    int randomNumber5 = random.nextInt(4);
    reponse[0] = "assets/audios/${code[randomNumber5]}.mp3";
    reponse[1] = "assets/images/${code[randomNumber5]}.png";
    reponse[2] = articles[randomNumber5];
    reponse[3] = propositions[randomNumber5];
  }

  List<dynamic> getReponse() {
    return reponse;
  }

  List<dynamic> getProposition() {
    return propositions;
  }

  List<dynamic> getPropositionImages() {
    return propositionsImages;
  }
}
