import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHelper {
  static AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> play(List<String> reponse, double speed) async {
    audioPlayer.setPlaybackRate(speed);
    //await audioPlayer.setSource(AssetSource(reponse[0].substring(7)));

    audioPlayer.play(AssetSource(reponse[0].substring(7)));
    audioPlayer
        .seek(Duration.zero); // to play the audio even when it's not completed
  }
}
