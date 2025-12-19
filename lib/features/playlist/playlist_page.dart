import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/provider/provider.dart';
import '../player/mini_player.dart';

class PlaylistPage extends HookConsumerWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlists = ref.watch(demoPlaylistsProvider);
    final playlist = playlists.first;
    final playbackController = ref.read(playbackControllerProvider);

    useEffect(() {
      debugPrint('PlaylistPage mounted');
      return null;
    }, []);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: Text(playlist.title), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 90),
        itemCount: playlist.songs.length,
        itemBuilder: (context, index) {
          final song = playlist.songs[index];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(song.coverUrl, width: 48, height: 48, fit: BoxFit.cover),
            ),
            title: Text(song.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(song.artist, style: TextStyle(color: Colors.grey.shade400)),
            trailing: const Icon(Icons.play_arrow_rounded, color: Colors.grey),
            onTap: () async {
              await playbackController.playSong(song);
              context.push('/player');
            },
          );
        },
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
