import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _DescriptionController = TextEditingController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 60),
            child: Text(
              "Modifier un profil",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/163/163847.png'),
                    ),
              Positioned(
                  bottom: -1,
                  left: 100,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue, //<-- SEE HERE

                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Selectioner une image'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Depuis la camera'),
                                      onTap: () {
                                        _getImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Depuis la gallerie'),
                                      onTap: () {
                                        _getImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.account_circle),
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
                      ))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: TextField(
            controller: _DescriptionController,
            onChanged: (value) {
              setState(() {
                size = value.length;
              });
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
            maxLines: null,
            textInputAction: TextInputAction.newline,
            decoration: const InputDecoration(
              labelText: 'Entrez votre nom',
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
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "$size/25",
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: Color.fromARGB(255, 44, 115, 210), fontSize: 12),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 40, top: 40),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: const [
        //       Expanded(flex: 6, child: SizedBox()),
        //       Icon(
        //         Icons.circle,
        //         size: 10,
        //         color: Color.fromARGB(255, 203, 203, 203),
        //       ),
        //       Expanded(child: SizedBox()),
        //       Icon(
        //         Icons.circle,
        //         size: 10,
        //         color: Color.fromARGB(255, 203, 203, 203),
        //       ),
        //       Expanded(child: SizedBox()),
        //       Icon(
        //         Icons.circle,
        //         size: 10,
        //         color: Color.fromARGB(255, 0, 105, 242),
        //       ),
        //       Expanded(flex: 6, child: SizedBox()),
        //     ],
        //   ),
        // ),
        Center(
          child: SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 164, 222)),
                onPressed: () {},
                child: Row(
                  children: const [
                    Expanded(child: SizedBox()),
                    Text("Enregister"),
                    Expanded(child: SizedBox()),
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
