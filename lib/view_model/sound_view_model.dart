import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundViewModel {
  final AudioPlayer backgroundPlayer = AudioPlayer(); //배경음악 객체
  final AudioPlayer effectsPlayer = AudioPlayer(); //효과음 객체
  final Map<String, AudioSource> effects = {}; //효과음 저장

  SoundViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    try {
      await backgroundPlayer.setAsset('assets/audios/game_music.mp3');
      backgroundPlayer.setLoopMode(LoopMode.one);
    } catch (e) {
      debugPrint("오디오 파일 초기화 오류: $e");
    }
  }

  ///오디오 파일 불러오고 재생
  Future<void> loadAudio() async {
    try {
      await backgroundPlayer.setAsset('assets/audios/game_music.mp3');
      effects['game_start'] = AudioSource.asset('assets/audios/game_start.mp3');
      effects['game_over'] = AudioSource.asset('assets/audios/game_over.mp3');
    } catch (e) {
      debugPrint("오디오 파일 초기화 오류: $e");
    }
    await Future.delayed(Duration.zero);
    playBackgroundMusic();
    playEffectSound('game_start');
  }

  ///배경음악 재생
  void playBackgroundMusic() {
    try {
      backgroundPlayer.setLoopMode(LoopMode.one);
      backgroundPlayer.play();
    } catch (e) {
      debugPrint("배경 음악 재생 오류: $e");
    }
  }

  ///특정 효과음 재생
  Future<void> playEffectSound(String effectName) async {
    try {
      final source = effects[effectName];
      if (source != null) {
        await effectsPlayer.setAudioSource(source);
        await Future.delayed(Duration.zero);
        effectsPlayer.play();
      }
    } catch (e) {
      debugPrint("효과음 재생 오류: $e");
    }
  }

  ///배경음악 소리 조절
  void setAudioVolume(double volume) {
    backgroundPlayer.setVolume(volume);
    effectsPlayer.setVolume(volume);
  }

  void dispose() {
    backgroundPlayer.dispose();
  }
}
