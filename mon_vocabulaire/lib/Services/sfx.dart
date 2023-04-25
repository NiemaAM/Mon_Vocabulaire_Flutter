import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sfx {
  static AudioPlayer sfxAudioPlayer = AudioPlayer();

  static Future<void> play(String name, double speed) async {
    sfxAudioPlayer.setPlaybackRate(speed);
    await sfxAudioPlayer.setSource(AssetSource(name));
    sfxAudioPlayer.play(AssetSource(name));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? sfxVolume = prefs.getDouble('sfxVolume');
    sfxAudioPlayer.setVolume(sfxVolume ?? 0.5);
    sfxAudioPlayer.seek(Duration.zero);
  }

  static void stop() {
    sfxAudioPlayer.stop();
  }

  static void dispose() {
    sfxAudioPlayer.dispose();
  }

  static void pause() {
    sfxAudioPlayer.pause();
  }

  static void resume() {
    sfxAudioPlayer.resume();
  }

  static void volume(double value) {
    sfxAudioPlayer.setVolume(value);
  }
}
