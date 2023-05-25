import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/ferme.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/bubble2.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import '../../Account/profil.dart';
import '../../Themes/themes.dart';
import '../jeux.dart';
import 'acceuil_subTheme.dart';

class TrouvailleThemes extends StatefulWidget {
  final User user;
  const TrouvailleThemes({super.key, required this.user});

  @override
  State<TrouvailleThemes> createState() => _TrouvailleThemesState();
}

class _TrouvailleThemesState extends State<TrouvailleThemes>
    with WidgetsBindingObserver {
  List<Widget> page = [];
  int _selectedIndex = 0;
  bool _isHome = true;
  bool _isProfil = false;
  bool _isGames = false;

  @override
  void initState() {
    super.initState();
    AudioBK.playBK();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      page = [
        Themes(user: widget.user),
        Profil(user: widget.user),
        Games(user: widget.user)
      ];
    });
  }

  @override
  void dispose() {
    super.dispose();
    AudioBK.pauseBK();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioBK.pauseBK();
    } else {
      AudioBK.playBK();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          setState(() {
            _isHome = true;
            _isProfil = false;
            _isGames = false;
          });
          break;
        case 1:
          setState(() {
            _isHome = false;
            _isProfil = true;
            _isGames = false;
          });
          break;
        case 2:
          setState(() {
            _isHome = false;
            _isProfil = false;
            _isGames = true;
          });
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/search.png",
              width: 40,
            ),
            const Text(
              "  Trouvaille",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      // body: page[_selectedIndex],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/ecole.png",
                    text: 'L’école',
                    callback: TrouvailleSubThemes(),
                    color: Palette.ecole,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/maison.png",
                    text: 'Maison et famille',
                    callback: TrouvailleSubThemes(),
                    color: Palette.maison,
                    type: "theme",
                  ),
                ],
              ),
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/cuisine_et_aliments.png",
                    text: 'cuisine_et_aliments',
                    callback: TrouvailleSubThemes(),
                    color: Palette.cuisine,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/animaux.png",
                    text: 'animaux',
                    callback: TrouvailleSubThemes(),
                    color: Palette.animaux,
                    type: "theme",
                  ),
                ],
              ),
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/mes_habits.png",
                    text: 'mes_habits',
                    callback: TrouvailleSubThemes(),
                    color: Palette.corps,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/sports.png",
                    text: 'sports',
                    callback: TrouvailleSubThemes(),
                    color: Palette.sports,
                    type: "theme",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
