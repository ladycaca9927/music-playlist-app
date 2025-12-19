import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:just_audio/just_audio.dart';

import '../model/playlist_model.dart';
import '../model/song_model.dart';

final audioPlayerProvider = Provider.autoDispose<AudioPlayer>((ref) {
  final player = AudioPlayer();

  ref.onDispose(() async {
    await player.dispose();
  });

  return player;
});

final currentSongProvider = StateProvider.autoDispose<Song?>((ref) => null);

final playbackControllerProvider = Provider<PlaybackController>((ref) {
  return PlaybackController(ref);
});

final selectedPlaylistProvider = StateProvider<Playlist?>((ref) => null);

final isAudioLoadingProvider = StateProvider<bool>((ref) => false);

final demoPlaylistsProvider = Provider<List<Playlist>>((ref) {
  final songs = [Song(id: '1', title: 'SoundHelix Song 1', artist: 'SoundHelix', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', coverUrl: 'https://picsum.photos/300?1'), Song(id: '2', title: 'SoundHelix Song 2', artist: 'SoundHelix', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', coverUrl: 'https://picsum.photos/300?2'),Song(id: '3', title: 'Never let go', artist: 'NDA', url: 'https://prosearch.tribeofnoise.com/artists/show/77505/43374', coverUrl: 'https://picsum.photos/300?3')];

  return [Playlist(id: 'playlist_1', title: 'My Favorites', coverUrl: 'https://picsum.photos/500', songs: songs)];
});

class PlaybackController {
  final Ref ref;

  PlaybackController(this.ref);

  AudioPlayer get _player => ref.read(audioPlayerProvider);

  Future<void> playSong(Song song) async {
    await _player.setUrl(song.url);
    await _player.play();
    ref.read(currentSongProvider.notifier).state = song;
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
    ref.read(currentSongProvider.notifier).state = null;
  }
}
