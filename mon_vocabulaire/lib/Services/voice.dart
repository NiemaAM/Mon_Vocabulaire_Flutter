import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Voice {
  static AudioPlayer voiceAudioPlayer = AudioPlayer();

  static Future<void> play(String name, double speed) async {
    await voiceAudioPlayer.setSource(AssetSource(name));
    voiceAudioPlayer.play(AssetSource(name));
    voiceAudioPlayer.setPlaybackRate(speed);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? voiceVolume = prefs.getDouble('voiceVolume');
    voiceAudioPlayer.setVolume(voiceVolume ?? 1);
    voiceAudioPlayer.seek(Duration.zero);
  }

  static void stop() {
    voiceAudioPlayer.stop();
  }

  static void dispose() {
    voiceAudioPlayer.dispose();
  }

  static void pause() {
    voiceAudioPlayer.pause();
  }

  static void resume() {
    voiceAudioPlayer.resume();
  }

  static void volume(double value) {
    voiceAudioPlayer.setVolume(value);
  }
}
