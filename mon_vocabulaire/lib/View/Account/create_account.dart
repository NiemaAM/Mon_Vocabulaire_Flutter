import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/View/Account/avatars.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // ignore: non_constant_identifier_names
  final TextEditingController _TextController = TextEditingController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  void createAccount(String nom, String image) {
    User newUser = User(
        name: nom,
        image: "assets/images/avatars/user.png",
        currentLevel: 1,
        coins: 0);
    DatabaseHelper().addUser(newUser);
  }

  Future<void> _getImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "AJOUTER",
        color: Palette.lightBlue,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          ListView(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Palette.pink,
                                  width: 8,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Palette.lightBlue,
                                backgroundImage: FileImage(_image!),
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Palette.pink,
                                  width: 8,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 100,
                                backgroundColor: Palette.white,
                                backgroundImage: AssetImage(
                                    'assets/images/avatars/user.png'),
                              ),
                            ),
                      Positioned(
                        bottom: 35,
                        right: 10,
                        child: Button(
                            callback: () {},
                            heigth: 60,
                            width: 60,
                            color: Palette.pink,
                            content: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                          child: Text('Selectioner une image')),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(
                                              Icons.camera_alt,
                                              color: Palette.blue,
                                            ),
                                            title:
                                                const Text('Depuis la camera'),
                                            onTap: () {
                                              _getImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.image,
                                              color: Palette.blue,
                                            ),
                                            title: const Text(
                                                'Depuis la gallerie'),
                                            onTap: () {
                                              _getImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.person,
                                              color: Palette.blue,
                                            ),
                                            title:
                                                const Text('Choisir un avatar'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                SlideTop(
                                                  page: const Avatars(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Palette.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 15, left: width / 7, right: width / 7),
              child: TextField(
                controller: _TextController,
                onChanged: (value) {
                  setState(() {});
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                maxLines: 1,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.edit_rounded,
                    color: Palette.lightBlue,
                    size: 30,
                  ),
                  labelText: 'Nom',
                  labelStyle: TextStyle(color: Palette.indigo, fontSize: 18),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.red, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.lightBlue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.lightBlue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.blue, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                    color: Palette.lightBlue,
                    width: 180,
                    callback: () {
                      createAccount(_TextController.text, "");
                      Navigator.pop(context);
                    },
                    content: const Center(
                        child: Text(
                      "AJOUTER",
                      style: TextStyle(
                          color: Palette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
            )
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Mon Vocabulaire",
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                    color: Palette.lightBlue,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
