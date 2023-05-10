import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Games/jeux.dart';
import 'package:mon_vocabulaire/View/Account/profil.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import '../Services/audio_background.dart';
import '../Widgets/app_bar.dart';
import 'Themes/themes.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
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
    return Scaffold(
        appBar: _selectedIndex == 0 || _selectedIndex == 2
            ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                automaticallyImplyLeading: false,
                elevation: 1,
                title: AppBarHome(user: widget.user),
              )
            : null,
        body: page[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.background,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _isHome
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).hoverColor,
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              const Expanded(flex: 3, child: SizedBox()),
              IconButton(
                icon: Icon(
                  Icons.gamepad,
                  color: _isGames
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).hoverColor,
                ),
                onPressed: () {
                  _onItemTapped(2);
                },
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _isProfil
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _onItemTapped(1);
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Palette.blue,
                  child: ClipOval(
                    child: Image.network(
                      widget.user
                          .image, //TODO: change this to images from gallery
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ));
  }
}
