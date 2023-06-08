import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Widgets/Appbars/app_bar.dart';
import '../../Widgets/Palette.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "A propos",
        color: Palette.blue,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              Text(
                "Mon vocabulaire",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.blue,
                  fontSize: 30,
                ),
              ),
              Text(
                "Application du vocabulaire francais",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "version 1.0.0",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.grey,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              Text(
                String.fromCharCode(34) +
                    "La manière la plus facile d'apprendre le vocabulaire francais depuis votre mobile." +
                    String.fromCharCode(34),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.blue,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/aboutus/free.png",
                    width: 100,
                    height: 100,
                  ),
                  Flexible(
                    child: Column(children: [
                      Text(
                        "GRATUIT",
                        style: TextStyle(
                          color: Palette.blue,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Apprenez chaque jour, suivez votre progression, passez tous les niveaux de difficulté, collectez des pieces pour chaque réponse correcte .",
                        textAlign: TextAlign.center,
                      )
                    ]),
                  ),
                ],
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/aboutus/offline.png",
                    width: 100,
                    height: 100,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          "HORS LIGNE",
                          style: TextStyle(
                            color: Palette.blue,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Apprenez à tout moment et n'importe où. Enrichissez votre vocabulaire.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/aboutus/fungame.png",
                    width: 100,
                    height: 100,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          "JEUX AMUSANTS",
                          style: TextStyle(
                            color: Palette.blue,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Jouez à une grande variété de jeux d'apprentissage et améliorez vos compétences d'écoute, de lecture et d'écriture.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 40,
                height: 40,
              ),
              Text("Description",
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.blue,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "    Mon Vocabulaire est une application hors ligne d'apprentissage du vocabulaire de la langue française qui utilise des technologies scientifiques basées sur des jeux pour changer la méthode d’apprentissage des enfants.",
                ),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "    Mon Vocabulaire propose de nombreux thèmes pour chaque niveau scolaire, ainsi les enfants peuvent étudier autant de mots qu'ils le souhaitent. Chaque thème est enseigné en 40 mots, et chaque niveau contient 240 mots."),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "    Notre application a été créée en 2023 en collaboration avec une équipe de développeurs mobiles avec la forte conviction que l'apprentissage du vocabulaire français doit être amusant, facile et accessible à tous les enfants du Maroc, quel que soit leur niveau de langue."),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "    L’application est développée dans le cadre d’une collaboration entre le Ministère de l'Education Nationale du Préscolaire et des Sports (MENPS) , le laboratoir national des ressources numériques”programme génie” et l’Ecole Supérieure de Technologie de Salé."),
              ),
              SizedBox(
                width: 30,
                height: 30,
              ),
              Image.asset(
                "assets/images/logo_ministere.png",
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/logo_genie.png",
                    width: 200,
                    height: 200,
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, left: 10.0),
                    child: Text(
                        "Le programme GENIE est une déclinaison opérationnelle de la stratégie nationale de généralisation des Technologies de l’Information et de la Communication dans l’Education (TICE). "),
                  )),
                ],
              ),
              Text(
                  "Il repose sur quatre composantes principales : infrastructure, formation des enseignants, ressources numériques et développement des usages."),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Text("Equipe de developpement ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.blue,
                  )),
              SizedBox(
                width: 30,
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo_ests.png",
                        width: 90,
                        height: 90,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "   L’équipe de développeurs provient de l’Ecole Superieure de Technologie de Salé qui autorisée à dispenser des formations sanctionnées par une Licence Professionnelle - LP, dont la LP Ingenieurie des applications mobiles - IAM. "),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 30,
                height: 30,
              ),
              Text("Noms des membres de léquipe",
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.blue,
                  )),
              SizedBox(
                width: 30,
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("BOUTARF\nAmina "),
                    Text("AOUTOUL\nNour"),
                    Text("MOUHSINE\nNada"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LAGUEDANI\nSoukaina"),
                    Text("EL KHALIFI\nMaroua"),
                    Text("NID-HADDOU\nHasnae"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ALAOUI MDAGHRI\nNiema"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
