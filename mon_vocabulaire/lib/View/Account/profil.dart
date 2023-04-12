import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_vocabulaire/Widgets/level.dart';

import 'package:mon_vocabulaire/Widgets/palette.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 60),
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
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/163/163847.png'),
                    ),
              // Positioned(
              //     bottom: -1,
              //     left: 100,
              //     child: CircleAvatar(
              //     radius: 20,
              //     backgroundColor: Colors.blue, //<-- SEE HERE
              //
              //         child: IconButton(
              //          onPressed: () {
              //          showDialog(
              //          context: context,
              //          builder: (BuildContext context) {
              //           return AlertDialog(
              //              title: const Text('Selectioner une image'),
              //              content: Column(
              //                mainAxisSize: MainAxisSize.min,
              //                children: <Widget>[
              //                  ListTile(
              //                    leading: const Icon(Icons.camera_alt),
              //                    title: const Text('Depuis la camera'),
              //                    onTap: () {
              //                    _getImage(ImageSource.camera);
              //                     Navigator.pop(context);
              //           },
              //         ),
              //                  ListTile(
              //                    leading: const Icon(Icons.image),
              //                    title: const Text('Depuis la gallerie'),
              //                     onTap: () {
              //                     _getImage(ImageSource.gallery);
              //                      Navigator.pop(context);
              //           },
              //         ),
              //                  ListTile(
              //                    leading: const Icon(Icons.account_circle),
              //                    title: const Text('Choisir un avatar'),
              //                     onTap: () {
              //                     _getImage(ImageSource.gallery);
              //                     Navigator.pop(context);
              //           },
              //         ),
              //       ],
              //     ),
              //   );},);},
              //           icon: const Icon(
              //           Icons.add_a_photo,
              //           color: Colors.white,
              //        ),
              //     )
              //    )
              // ),
            ],
          ),
        ),
        Column(
          children: const [
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Text(
              "Salma Idrissi",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Level(
          width: width * 0.9,
          heigth: height * 0.15,
          color: Palette.pink,
          radius: 30,
          text: "CE1",
          isImage: true,
          label: false,
          mot: "150/240",
          coins: 20,
          image: "https://cdn-icons-png.flaticon.com/512/7645/7645294.png",
          callback: () {},
        ),
        Level(
          width: width * 0.9,
          heigth: height * 0.15,
          color: Colors.grey,
          radius: 30,
          text: "CE2",
          isImage: true,
          label: false,
          mot: "0/240",
          coins: 0,
          image: "https://cdn-icons-png.flaticon.com/512/3064/3064155.png",
          callback: () {},
        ),
        Level(
          width: width * 0.9,
          heigth: height * 0.15,
          color: Colors.grey,
          radius: 30,
          text: "CE3",
          isImage: true,
          label: false,
          mot: "0/240",
          coins: 0,
          image: "https://cdn-icons-png.flaticon.com/512/3064/3064155.png",
          callback: () {},
        ),
      ]),
    );
  }
}
