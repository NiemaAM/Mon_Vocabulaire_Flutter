import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Account/accounts.dart';
import 'package:mon_vocabulaire/Widgets/icon_widget.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:mon_vocabulaire/View/Account/edit_account.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:mon_vocabulaire/Services/local_notification_service.dart';
import 'package:mon_vocabulaire/Provider/theme.provider.dart';
import 'package:provider/provider.dart';

class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({super.key});

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  User user = User(
      id: 1,
      name: "salma",
      image: "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
      current_level: 1,
      words_per_level: {1: 120},
      coins: 20,
      words_per_subtheme: {
        1: 65,
        2: 25,
        3: 40,
        4: 28,
        5: 33,
        6: 50,
        7: 65,
        8: 25,
        9: 40,
        10: 28,
        11: 33,
        12: 50,
      },
      stars_per_subtheme: {
        1: true,
        2: false,
        3: false,
        4: true,
        5: true,
        6: false,
        7: true,
        8: false,
        9: false,
        10: true,
        11: true,
        12: false,
      });

  bool notifOn = true;
  bool darkOn = false;
  bool songOn = true;
  bool soundOn = true;

  LocalNotificationService localNotificationService =
      LocalNotificationService();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        title: const Text("Paramètres"),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  user: user,
                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: "Page d'acceuil",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              //Profile + edite profile
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 0, right: 0, bottom: 40),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: width / 5,
                      backgroundColor: Palette.blue,
                      child: ClipOval(
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Salma",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text("Niveau 1")
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon((Icons.edit), color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAccount(
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //DarkMode
              Row(
                children: [
                  const IconWidget(
                      icon: Icons.dark_mode, color: Color(0xFF170635)),
                  SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  Container(
                    child: Text(
                      "Mode Sombre",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CupertinoSwitch(

                      // overrides the default green color of the track
                      activeColor: Palette.lightGreen,
                      // color of the round icon, which moves from right to left
                      thumbColor: darkOn ? Palette.darkGreen : Palette.blue,
                      // when the switch is off
                      trackColor: Palette.lightGrey,
                      // boolean variable value
                      value: themeProvider.isDarkMode,
                      // changes the state of the switch
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);

                        if (darkOn) {
                          setState(() {
                            darkOn = false;
                          });
                        } else {
                          setState(() {
                            darkOn = true;
                          });
                        }
                      }),
                ],
              ),

              const Divider(),

              //Géneral Settings
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: Title(
                    color: Colors.black,
                    child: Text(
                      "General",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),

              //Musique de fond
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(
                        icon: Icons.music_note, color: Palette.pink),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: Text(
                        "Musique de fond",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CupertinoSwitch(

                        // overrides the default green color of the track
                        activeColor: Palette.lightGreen,
                        // color of the round icon, which moves from right to left
                        thumbColor: songOn ? Palette.darkGreen : Palette.blue,
                        // when the switch is off
                        trackColor: Palette.lightGrey,
                        // boolean variable value
                        value: songOn,
                        // changes the state of the switch
                        onChanged: (Value) {
                          if (songOn) {
                            setState(() {
                              songOn = false;
                            });
                          } else {
                            setState(() {
                              songOn = true;
                            });
                          }
                        }),
                  ],
                ),
              ),

              //sond's effect
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(
                        icon: Icons.volume_up,
                        color: Color.fromRGBO(255, 167, 38, 1)),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: Text(
                        "Effets Sonores",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CupertinoSwitch(

                        // overrides the default green color of the track
                        activeColor: Palette.lightGreen,
                        // color of the round icon, which moves from right to left
                        thumbColor: soundOn ? Palette.darkGreen : Palette.blue,
                        // when the switch is off
                        trackColor: Palette.lightGrey,
                        // boolean variable value
                        value: soundOn,
                        // changes the state of the switch
                        onChanged: (Value) {
                          if (soundOn) {
                            setState(() {
                              soundOn = false;
                            });
                          } else {
                            setState(() {
                              soundOn = true;
                            });
                          }
                        }),
                  ],
                ),
              ),

              //Notification
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(
                        icon: Icons.notifications, color: Palette.lighterGreen),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: Palette.lightGreen,
                        // color of the round icon, which moves from right to left
                        thumbColor: notifOn ? Palette.darkGreen : Palette.blue,
                        // when the switch is off
                        trackColor: Palette.lightGrey,
                        // boolean variable value
                        value: notifOn,
                        // changes the state of the switch
                        onChanged: (value) {
                          if (notifOn) {
                            setState(() {
                              notifOn = false;
                            });
                            localNotificationService.showNotification(
                                "Tu nous as manqué",
                                "Il y a encore des mots à decouverire ");
                          } else {
                            setState(() {
                              notifOn = true;
                            });
                            localNotificationService.stopNotifications();
                          }
                        })
                  ],
                ),
              ),

              const Divider(),

              //Retour
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: Title(
                    color: Colors.black,
                    child: Text(
                      "Plus d'info et assistance",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),

              //bug
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(icon: Icons.help, color: Colors.purple),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Aide",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Accounts(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(icon: Icons.feedback, color: Palette.blue),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Laisser un avis",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(
                        icon: Icons.info, color: Colors.greenAccent),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "À propos",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),

              //Retour
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: Title(
                    color: Colors.black,
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(icon: Icons.logout, color: Colors.blue),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Changer de compte",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Accounts(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const IconWidget(icon: Icons.delete, color: Colors.red),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          "Supprimer ce compte",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
