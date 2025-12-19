import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../core/provider/provider.dart';

class PlayerPage extends HookConsumerWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final song = ref.watch(currentSongProvider);

    final position = useStream(player.positionStream, initialData: Duration.zero);
    final duration = useStream(player.durationStream, initialData: Duration.zero);
    final isPlaying = useStream(player.playingStream, initialData: false);

    if (song == null) return const Scaffold();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadiusGeometry.circular(16), child: Image.network(song.coverUrl, width: 260)),
            const SizedBox(height: 24),
            Text(song.title, style: const TextStyle(fontSize: 22)),
            Text(song.artist, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 32),

            Slider(
              value: position.data!.inSeconds.toDouble(),
              max: duration.data!.inSeconds.toDouble().clamp(1, double.infinity),
              onChanged: (value) {
                player.seek(Duration(seconds: value.toInt()));
              },
              activeColor: const Color(0xFF1DB954),
              inactiveColor: Colors.white60,
            ),

            IconButton(
              iconSize: 72,
              icon: Icon(isPlaying.data! ? Icons.pause_circle : Icons.play_circle),
              onPressed: () {
                isPlaying.data! ? player.pause() : player.play();
              },
            ),
          ],
        ),
      ),
    );
  }
}
