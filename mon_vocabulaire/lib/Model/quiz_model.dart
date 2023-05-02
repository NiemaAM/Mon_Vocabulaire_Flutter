import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mon_vocabulaire/Model/quiz_prposition.dart';
import 'package:mon_vocabulaire/Model/quiz_prposition_lettres.dart';

import 'lesson_model.dart';

class QuizModel {
  List<Proposition> questions = [];
  List<PropositionLettres> questionsLettres = [];
  int size = 5;
  int loopsize = 5;
  List<dynamic> propositions = ["sons.mp3", "image.png", "article", "mot"];
  List<dynamic> propositionsImages = [
    "sons.mp3",
    "image.png",
    "article",
    "mot"
  ];
  List<dynamic> reponse = ["sons.mp3", "image.png", "article", "mot"];
  List<String> lettresReponse = [];
  List<String> lettresProposition = [];
  List<String> lettresQuestion = [];

  Future<List<Lesson>> getLesson(String theme, String subtheme) async {
    // Load the JSON data from the asset file
    String jsonStr = await rootBundle.loadString('assets/data.json');

    // Parse the JSON string to a map
    Map<String, dynamic> jsonMap = json.decode(jsonStr);

    // Get the map of elements
    Map<String, dynamic> elementsMap = jsonMap[theme][subtheme];
    size = elementsMap.length;
    // Get a list of the 'mot' values from the elements map
    List<dynamic> motList =
        elementsMap.values.map((valueMap) => valueMap['mot']).toList();

    // Get a list of the 'article' values from the elements map
    List<dynamic> articleList =
        elementsMap.values.map((valueMap) => valueMap['article']).toList();

    // Get a list of the 'code' values from the elements map
    List<dynamic> codeList =
        elementsMap.values.map((valueMap) => valueMap['code']).toList();

    List<Lesson> lesson = [];
    for (int i = 0; i < motList.length; i++) {
      Lesson l = Lesson(
          image: "assets/images/${codeList[i]}.png",
          audio: "audios/${codeList[i]}.mp3",
          article: articleList[i],
          mot: motList[i]);
      if (!lesson.contains(l)) {
        lesson.add(l);
      }
    }
    return lesson;
  }

  Future<PropositionLettres> getRandomLettres(
      String theme, String subtheme) async {
    // Load the JSON data from the asset file
    String jsonStr = await rootBundle.loadString('assets/data.json');

    // Parse the JSON string to a map
    Map<String, dynamic> jsonMap = json.decode(jsonStr);

    // Get the map of elements
    Map<String, dynamic> elementsMap = jsonMap[theme][subtheme];
    size = elementsMap.length;
    if (size >= 10) {
      loopsize = 10;
    } else {
      loopsize = size;
    }
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
    int randomNumber = random.nextInt(motList.length);
    List<String> rep = ["", "", "", ""];

    rep[0] = "audios/${codeList[randomNumber]}.mp3";
    rep[1] = "assets/images/${codeList[randomNumber]}.png";
    rep[2] = articleList[randomNumber];
    rep[3] = motList[randomNumber];

    List<String> props = [];
    List<String> reps = [];
    reps = motList[randomNumber].split("");

    while (props.length < 3) {
      int code = random.nextInt(26) + 65;
      if (!reps.contains(String.fromCharCode(code).toLowerCase()) &&
          !props.contains(String.fromCharCode(code).toLowerCase())) {
        props.add(String.fromCharCode(code).toLowerCase());
      }
    }
    while (props.length < 5) {
      int code = random.nextInt(reps.length);
      if (!props.contains(String.fromCharCode(code).toLowerCase())) {
        props.add(reps[code]);
      }
    }
    props.shuffle();
    List<String> quest = [];
    for (String i in reps) {
      if (!props.contains(i)) {
        quest.add(i);
      } else {
        quest.add("??");
      }
    }

    PropositionLettres prop = PropositionLettres(
        reponse: rep,
        lettresReponse: reps,
        lettresProposition: props,
        lettresQuestion: quest);

    return prop;
  }

  Future<List<PropositionLettres>> getRandomPropositionsLettres(
      String theme, String subtheme) async {
    List<PropositionLettres> prop = [];
    Set<String> uniqueValues = <String>{};
    PropositionLettres prop1;
    while (prop.length <= loopsize) {
      prop1 = await getRandomLettres(theme, subtheme);
      if (!uniqueValues.contains(prop1.reponse[3])) {
        uniqueValues.add(prop1.reponse[3]);
        prop.add(prop1);
      }
    }
    for (PropositionLettres p in prop) {
      questionsLettres.add(p);
    }
    return prop;
  }

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
    reponse[0] = "audios/${code[randomNumber5]}.mp3";
    reponse[1] = "assets/images/${code[randomNumber5]}.png";
    reponse[2] = articles[randomNumber5];
    reponse[3] = propositions[randomNumber5];
  }

  Future<Proposition> getRandomProps(String theme, String subtheme) async {
    Proposition proposition = Proposition(
        propositions: ["", "", "", ""],
        propositionsImages: ["", "", "", ""],
        reponse: ["", "", "", ""]);
    // Load the JSON data from the asset file
    String jsonStr = await rootBundle.loadString('assets/data.json');

    // Parse the JSON string to a map
    Map<String, dynamic> jsonMap = json.decode(jsonStr);

    // Get the map of elements
    Map<String, dynamic> elementsMap = jsonMap[theme][subtheme];

    size = elementsMap.length;
    if (size >= 10) {
      loopsize = 10;
    } else {
      loopsize = size;
    }

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

    proposition.propositions[0] = motList[randomNumber1];
    proposition.propositions[1] = motList[randomNumber2];
    proposition.propositions[2] = motList[randomNumber3];
    proposition.propositions[3] = motList[randomNumber4];
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
    List<String> mots = [
      motList[randomNumber1],
      motList[randomNumber2],
      motList[randomNumber3],
      motList[randomNumber4]
    ];
    proposition.propositionsImages[0] = "assets/images/${code[0]}.png";
    proposition.propositionsImages[1] = "assets/images/${code[1]}.png";
    proposition.propositionsImages[2] = "assets/images/${code[2]}.png";
    proposition.propositionsImages[3] = "assets/images/${code[3]}.png";

    int randomNumber5 = random.nextInt(4);
    proposition.reponse[0] = "audios/${code[randomNumber5]}.mp3";
    proposition.reponse[1] = "assets/images/${code[randomNumber5]}.png";
    proposition.reponse[2] = articles[randomNumber5];
    proposition.reponse[3] = mots[randomNumber5];

    return proposition;
  }

  Future<List<Proposition>> getRandomPropositions(
      String theme, String subtheme) async {
    List<Proposition> prop = [];
    Set<String> uniqueValues = <String>{};
    Proposition prop1;
    while (prop.length < loopsize) {
      prop1 = await getRandomProps(theme, subtheme);
      if (!uniqueValues.contains(prop1.reponse[3])) {
        uniqueValues.add(prop1.reponse[3]);
        prop.add(prop1);
      }
    }
    for (Proposition p in prop) {
      questions.add(p);
    }
    return prop;
  }

  int getSize() {
    return loopsize;
  }

  int getLessonSize() {
    return size;
  }

  List<Proposition> getQuestions() {
    return questions;
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

  List<String> getLettresReponse() {
    return lettresReponse;
  }

  List<String> getLettresQuestion() {
    return lettresQuestion;
  }

  List<String> getLettresProposition() {
    return lettresProposition;
  }
}
