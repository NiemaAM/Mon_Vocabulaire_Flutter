// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/View/Account/avatars.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _TextController = TextEditingController();
  RealtimeDataController controller = RealtimeDataController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String path_image = '';

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<String> saveimage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${path.basename(imageFile.path)}';
    final savedImage = await imageFile.copy(imagePath);
    return savedImage.path;
  }

  Future<void> _getimage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imagePath = await saveimage(imageFile);
      setState(() {
        _image = imageFile;
        path_image = imagePath;
      });
    }
  }

  void createAccount(String nom, String image) async {
    String imagePath = path_image;
    if (_image != null && !imagePath.startsWith('assets')) {
      // Save the image file and get the saved path
      imagePath = await saveimage(_image!);
    } else if (_image == null) {
      imagePath = "assets/images/avatars/user.png";
    }
    User newUser = User(
      name: nom,
      image: imagePath,
      currentLevel: 1,
      coins: 0,
    );
    DatabaseHelper().addUser(newUser);
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
                                backgroundImage: path_image.startsWith('assets')
                                    ? AssetImage(path_image) as ImageProvider
                                    : FileImage(_image!),
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
                                              _getimage(ImageSource.camera);
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
                                              _getimage(ImageSource.gallery);
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
                                            onTap: () async {
                                              final selectedImagePath =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute<String>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const Avatars(),
                                                ),
                                              );
                                              if (selectedImagePath != null) {
                                                setState(() {
                                                  path_image =
                                                      selectedImagePath;
                                                  _image = File(path_image);
                                                });
                                              }
                                              Navigator.pop(context);
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
                maxLength: 10,
                controller: _TextController,
                onChanged: (value) {
                  setState(() {});
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.edit_rounded,
                    color: Palette.lightBlue,
                    size: 30,
                  ),
                  labelText: 'Nom',
                  labelStyle:
                      const TextStyle(color: Palette.indigo, fontSize: 18),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.red, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.lightBlue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.lightBlue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.blue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorText: _TextController.text.isEmpty
                      ? '*Le nom est obligatoire'
                      : null, // Add this line
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
                      if (_TextController.text.isNotEmpty) {
                        createAccount(_TextController.text, "");
                        Navigator.pop(context);
                      } else {
                        Sfx.play("audios/sfx/zew.mp3", 1);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Palette.pink,
                          content: Text(
                            'Le nom est obligatoire',
                            style:
                                TextStyle(color: Palette.white, fontSize: 18),
                          ),
                        ));
                      }
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
