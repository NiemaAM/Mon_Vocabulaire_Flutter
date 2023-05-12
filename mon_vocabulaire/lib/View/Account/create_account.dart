import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
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
      appBar: AppBar(
        title: const Text("Créer un compte"),
        elevation: 1,
      ),
      body: ListView(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundColor: Palette.blue,
                          backgroundImage: FileImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 100,
                          backgroundColor: Palette.blue,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/3371/3371919.png'),
                        ),
                  Positioned(
                    bottom: 15,
                    left: 50,
                    child: Button(
                        callback: () {},
                        heigth: 60,
                        width: 100,
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
                                        title: const Text('Depuis la camera'),
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
                                        title: const Text('Depuis la gallerie'),
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
                                        title: const Text('Choisir un avatar'),
                                        onTap: () {
                                          _getImage(ImageSource.gallery);
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
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40, left: width / 5, right: width / 5),
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
              labelText: 'Pseudo',
              labelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Button(
                callback: () {
                  Navigator.pop(context);
                },
                content: const Center(
                    child: Text(
                  "Créer",
                  style: TextStyle(color: Palette.white, fontSize: 16),
                ))),
          ),
        )
      ]),
    );
  }
}
