import 'package:audioplayers/audioplayers.dart';

class Audio_BK {
  static AudioPlayer playerBK = AudioPlayer();

  static void playBK() async {
    await playerBK.play(AssetSource("audios/Unused-Shop-Loop.mp3"));
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
