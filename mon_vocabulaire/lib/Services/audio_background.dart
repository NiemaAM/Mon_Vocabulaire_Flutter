import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioBK {
  static AudioPlayer playerBK = AudioPlayer();

  static void playBK() async {
    playerBK.play(AssetSource("audios/background_music.mp3"));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? bkVolume = prefs.getDouble('bkVolume');
    playerBK.setVolume(bkVolume ?? 0.5);
    playerBK.setReleaseMode(ReleaseMode.loop);
  }

  static void stopBK() {
    playerBK.stop();
  }

  static void pauseBK() {
    playerBK.pause();
  }

  static void disposeBK() {
    playerBK.dispose();
  }

  static void resumeBK() {
    playerBK.resume();
  }

  static void volumeBK(double val) {
    playerBK.setVolume(val);
  }
}
