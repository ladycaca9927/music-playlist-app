import 'package:music_mobile_app/core/model/song_model.dart';

class Playlist {
  final String id;
  final String title;
  final String coverUrl;
  final List<Song> songs;

  const Playlist({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.songs,
  });
}