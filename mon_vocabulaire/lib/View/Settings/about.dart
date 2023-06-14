import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Mon Vocabulaire",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.lightBlue,
                      fontSize: 30,
                    ),
                  ),
                ),
                const Text(
                  "Application de Vocabulaire Français",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Palette.indigo),
                ),
                const Text(
                  "version 1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.grey,
                    fontSize: 15,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/encour.gif",
                        width: 100,
                      ),
                      const Text(
                        "En cours de \ndéveloppement",
                        style: TextStyle(
                            color: Palette.indigo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "\"La meilleure façon d'apprendre facilement le vocabulaire français depuis votre appareil mobile.\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Palette.lightBlue,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/free.png",
                      width: 100,
                      height: 100,
                    ),
                    Flexible(
                      child: Column(children: const [
                        Text(
                          "GRATUITE",
                          style: TextStyle(
                              color: Palette.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "Apprenez chaque jour, suivez votre progression, relevez tous les niveaux de difficulté et accumulez des pièces pour chaque réponse correcte.",
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/offline.png",
                      width: 100,
                      height: 100,
                    ),
                    Flexible(
                      child: Column(
                        children: const [
                          Text(
                            "HORS LIGNE",
                            style: TextStyle(
                                color: Palette.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Apprenez à tout moment et n'importe où. Enrichissez votre vocabulaire.",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/fungame.png",
                      width: 100,
                      height: 100,
                    ),
                    Flexible(
                      child: Column(
                        children: const [
                          Text(
                            "JEUX AMUSANTS",
                            style: TextStyle(
                                color: Palette.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Profitez d'une grande variété de jeux d'apprentissage et améliorez vos compétences en écoute, lecture et écriture.",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("Description",
                      style: TextStyle(
                          fontSize: 18,
                          color: Palette.lightBlue,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/images/logo_ministere.png",
                    width: width > 500 ? width / 2 : width,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    "     Mon Vocabulaire est une application hors ligne d'apprentissage du vocabulaire français qui utilise des technologies scientifiques basées sur des jeux pour révolutionner la méthode d'apprentissage des enfants.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    "     Mon Vocabulaire offre de nombreux thèmes adaptés à chaque niveau scolaire, permettant aux enfants d'étudier autant de mots qu'ils le souhaitent. Chaque thème propose 40 mots et chaque niveau comprend 240 mots.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    "     Cette application a été créée en 2023 en collaboration avec une équipe de développeurs mobiles qui croit fermement que l'apprentissage du vocabulaire français doit être amusant, facile et accessible à tous les enfants du Maroc, quel que soit leur niveau de langue.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  child: Text(
                    "     L'application est développée en partenariat avec le Ministère de l'Éducation Nationale du Préscolaire et des Sports (MENPS), le laboratoire national des ressources numériques \"Programme GENIE\" et l'École Supérieure de Technologie de Salé.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Text("Programme GENIE",
                    style: TextStyle(
                        fontSize: 18,
                        color: Palette.lightBlue,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Image.asset(
                    "assets/images/logo_genie.png",
                    width: 200,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "     Le Programme GENIE est une initiative concrète de la stratégie nationale de généralisation des Technologies de l'Information et de la Communication dans l'Éducation (TICE).",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Text(
                  "     Il repose sur quatre composantes clés : infrastructure, formation des enseignants, ressources numériques et développement des usages.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                const Text("Équipe de Développement",
                    style: TextStyle(
                        fontSize: 18,
                        color: Palette.lightBlue,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/logo_ests.png",
                            width: 90,
                            height: 90,
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "     L'équipe de développeurs est issue de l'École Supérieure de Technologie de Salé, habilitée à dispenser des formations sanctionnées par une Licence Professionnelle (LP), dont la LP d'Ingénierie des Applications Mobiles (IAM).",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Text("Membres de l'Équipe :",
                      style: TextStyle(
                          fontSize: 18,
                          color: Palette.lightBlue,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "ALAOUI MDAGHRI\nNiema",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "BOUTARF\nAmina",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "EL KHALIFI\nMaroua",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "MOUHSINE\nNada",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "AOUTOUL\nNour",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "NID-HADDOU\nHasnae",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text(
                    "LAGUEDANI\nSoukaina",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          CustomAppBar(
            title: "A propos",
            color: Palette.lightBlue,
            automaticallyImplyLeading: true,
            icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info),
                enableFeedback: false,
                isSelected: false),
          ),
        ],
      ),
    );
  }
}
