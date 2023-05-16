// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon_vocabulaire/Themes/theme_provider.dart';
import 'package:mon_vocabulaire/Services/local_notification_service.dart';
import 'package:mon_vocabulaire/View/Account/accounts.dart';
import 'package:mon_vocabulaire/View/Account/first_screen.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/audio_background.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/round_icon_widget.dart';
import '../Account/edit_account.dart';

class SettingsPage extends StatefulWidget {
  final User user;
  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final myController = TextEditingController();
  String captchaValue = '';
  String captchaImagePath = '';
  bool captchaVerified = false;
  Map<String, dynamic> captchaData = {};

  bool notifOn = false;
  bool darkOn = false;
  bool soundOn = true;
  double bkVolume = 1;
  double sfxVolume = 1;
  double voiceVolume = 1;

  LocalNotificationService localNotificationService =
      LocalNotificationService();

  ThemeProvider theme = ThemeProvider();

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isDark = prefs.getBool('isDark');
    setState(() {
      darkOn = isDark ?? false;
    });
  }

  Future<void> getNotifState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? notif = prefs.getBool('notification');
    setState(() {
      notifOn = notif ?? false;
    });
  }

  Future<void> getBkVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? _bkVolume = prefs.getDouble('bkVolume');
    setState(() {
      bkVolume = _bkVolume ?? 0.5;
    });
  }

  Future<void> setBkVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('bkVolume', bkVolume);
    AudioBK.volumeBK(bkVolume);
  }

  Future<void> getSfxVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? _sfxVolume = prefs.getDouble('sfxVolume');
    setState(() {
      sfxVolume = _sfxVolume ?? 0.5;
    });
  }

  Future<void> setSfxVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sfxVolume', sfxVolume);
    Sfx.volume(sfxVolume);
  }

  Future<void> getVoiceVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? _voiceVolume = prefs.getDouble('voiceVolume');
    setState(() {
      voiceVolume = _voiceVolume ?? 1;
    });
  }

  Future<void> setVoiceVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('voiceVolume', voiceVolume);
    Voice.volume(voiceVolume);
  }

  Future<void> loadCaptchaData() async {
    // Load the captcha data from a local JSON file
    String captchaDataJson =
        await rootBundle.loadString('assets/data/captcha_data.json');
    captchaData = json.decode(captchaDataJson);
    // Generate a new captcha image
    generateCaptchaImage();
  }

  void generateCaptchaImage() {
    // Generate a random captcha image code
    List<String> captchaCodes = captchaData.keys.toList();
    // final Random random = Random();
    String captchaCode = captchaCodes[Random().nextInt(captchaCodes.length)];

    captchaValue = captchaData[captchaCode];
    // Load the corresponding captcha image from assets
    captchaImagePath = 'assets/images/captcha/$captchaCode.png';
  }

  void verifyCaptcha(String input) {
    // Verify the user's input against the captcha value
    captchaVerified = input == captchaValue;
    generateCaptchaImage();

    if (captchaVerified) {
      AwesomeDialog(
        padding: const EdgeInsets.only(left: 15, right: 15),
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 30),
          child: Column(
            children: const [
              Text(
                'Verrouillage Parental',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Compte supprimé'),
              ),
            ],
          ),
        )),
      ).show();
    } else {
      AwesomeDialog(
        padding: const EdgeInsets.only(left: 15, right: 15),
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        body: Center(
            child: Column(
          children: [
            const Text(
              'Verrouillage Parental',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Code erroné.\nEntrez le code affiché ci-dessous :',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(captchaImagePath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Entrez le code ici'),
                controller: myController,
              ),
            ),
          ],
        )),
        btnCancelText: "Vérifier",
        btnCancelOnPress: () {
          verifyCaptcha(myController.text);
          myController.clear();
        },
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    getNotifState();
    getBkVolume();
    getSfxVolume();
    getVoiceVolume();
    getTheme();
    loadCaptchaData();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("audios/sfx/pop.mp3", 1);
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        children: [
          //Profile + edite profile
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 40),
            child: Row(
              children: [
                CircleAvatar(
                  radius: width / 5,
                  backgroundColor: Palette.blue,
                  child: ClipOval(
                    child: Image.asset(
                      widget.user.image,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                Column(
                  children: [
                    Text(
                      widget.user.name.replaceFirst(
                          widget.user.name.characters.first,
                          widget.user.name.characters.first.toUpperCase()),
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Niveau ${widget.user.current_level}",
                      style: const TextStyle(color: Palette.darkGrey),
                    )
                  ],
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.blue,
                  ),
                  child: IconButton(
                    icon: const Icon((Icons.edit), color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAccount(
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),

          //Géneral Settings
          Title(
              color: Colors.black,
              child: const Text(
                "Général",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )),
          const Divider(),

          //Musique de fond
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    RoundIconWidget(
                        icon: Icons.music_note, color: Palette.pink),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Musique de fond",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Slider(
                  min: 0.0,
                  max: 1.0,
                  value: bkVolume,
                  activeColor: Palette.pink,
                  onChanged: (value) {
                    setState(() {
                      bkVolume = value;
                    });
                    setBkVolume();
                  },
                )
              ],
            ),
          ),

          //sond's effect
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    RoundIconWidget(
                        icon: Icons.volume_up, color: Palette.orange),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Effets Sonores",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Slider(
                  min: 0.0,
                  max: 1.0,
                  value: sfxVolume,
                  activeColor: Palette.orange,
                  onChanged: (value) {
                    setState(() {
                      sfxVolume = value;
                    });
                    setSfxVolume();
                  },
                )
              ],
            ),
          ),

          //voix
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    RoundIconWidget(
                        icon: Icons.record_voice_over, color: Palette.indigo),
                    SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Voix",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Slider(
                  min: 0.0,
                  max: 1.0,
                  value: voiceVolume,
                  activeColor: Palette.indigo,
                  onChanged: (value) {
                    setState(() {
                      voiceVolume = value;
                    });
                    setVoiceVolume();
                  },
                )
              ],
            ),
          ),

          //Notification
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(
                    icon: Icons.notifications, color: Palette.lightGreen),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 16.0,
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
                        localNotificationService.setNotificationState(false);
                      } else {
                        setState(() {
                          notifOn = true;
                        });
                        localNotificationService.setNotificationState(true);
                      }
                    })
              ],
            ),
          ),

          //DarkMode
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(
                    icon: Icons.dark_mode, color: Palette.black),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                const Text(
                  "Mode Sombre",
                  style: TextStyle(
                    fontSize: 16.0,
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
                    value: darkOn,
                    // changes the state of the switch
                    onChanged: (value) {
                      if (darkOn) {
                        setState(() {
                          darkOn = false;
                        });
                      } else {
                        setState(() {
                          darkOn = true;
                        });
                      }
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setTheme(darkOn);
                    }),
              ],
            ),
          ),

          //Retour
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Title(
                color: Colors.black,
                child: const Text(
                  "Informations",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
          ),
          const Divider(),
          //bug
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(icon: Icons.help, color: Colors.purple),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    "Aide",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Accounts(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(
                    icon: Icons.feedback, color: Palette.blue),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    "Laisser un avis",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(
                    icon: Icons.info, color: Palette.lighterGreen),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    "À propos",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          //Retour
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Title(
                color: Colors.black,
                child: const Text(
                  "Compte",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(icon: Icons.logout, color: Palette.blue),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    "Changer de compte",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstSceen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                const RoundIconWidget(icon: Icons.delete, color: Palette.red),
                const SizedBox(
                  width: 25,
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    "Supprimer ce compte",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    AwesomeDialog(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Cette action est irréversible',
                            desc:
                                'Êtes-vous certain de vouloir supprimer ce compte ?',
                            btnCancelText: "Supprimer",
                            btnCancelOnPress: () {
                              AwesomeDialog(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                context: context,
                                headerAnimationLoop: false,
                                dialogType: DialogType.noHeader,
                                animType: AnimType.rightSlide,
                                body: Center(
                                    child: Column(
                                  children: [
                                    const Text(
                                      'Verrouillage Parental',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Entrez le code affiché ci-dessous :'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(captchaImagePath),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            hintText: 'Entrez le code ici'),
                                        controller: myController,
                                      ),
                                    ),
                                  ],
                                )),
                                btnCancelText: "Vérifier",
                                btnCancelOnPress: () {
                                  verifyCaptcha(myController.text);
                                  myController.clear();
                                },
                              ).show();
                            },
                            btnOkText: "Annuler",
                            btnOkOnPress: () {})
                        .show();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
