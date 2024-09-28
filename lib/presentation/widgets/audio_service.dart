import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Play audio from a file path
  Future<void> playAudioFromFile(String filePath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  // Pause the currently playing audio
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  // Resume the paused audio
  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
  }

  // Stop the audio playback
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  // Dispose of the audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
