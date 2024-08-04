import 'package:amc/data.dart';
import 'package:amc/widget/apple_slider.dart';
import 'package:amc/widget/future_container.dart';
import 'package:amc/widget/music_cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/player_page.dart';

class CtrlBar extends StatefulWidget {
  const CtrlBar({super.key});

  @override
  State<CtrlBar> createState() => _CtrlBarState();
}

class _CtrlBarState extends State<CtrlBar> {
  final heroTag = UniqueKey();
  final c = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.to(() => PlayerPage(heroTag)),
            child: Hero(
              tag: heroTag,
              child: Obx(() => MusicCover(media: c.curMedia, size: 80)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Obx(() {
                  return FutureContainer(
                    c.curMedia.title,
                    builder: (context, value) {
                      return Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    },
                  );
                }),
                Obx(() {
                  return FutureContainer(
                    c.curMedia.artist,
                    builder: (context, value) {
                      if (value == null) return const SizedBox.shrink();
                      return Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    },
                  );
                }),
                Obx(() {
                  return AppleSlider(
                    value: c.position().inMilliseconds.toDouble(),
                    total: c.duration().inMilliseconds.toDouble(),
                    onChange: (value) => c.player.seek(value.ms),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              final index = c.playIndex();
              if (index == 0) {
                c.playIndex(c.playlist.length - 1);
              } else {
                c.playIndex(index - 1);
              }
              c.player.play(c.curMedia.source);
            },
            icon: const Icon(CupertinoIcons.backward_fill),
          ),
          IconButton(
            onPressed: () {
              if (c.isPlaying) {
                c.player.pause();
              } else {
                c.player.play(c.curMedia.source);
              }
            },
            icon: Obx(() => Icon(
                  c.isPlaying
                      ? CupertinoIcons.pause_fill
                      : CupertinoIcons.play_fill,
                )),
          ),
          IconButton(
            onPressed: () {
              final index = c.playIndex();
              if (index == c.playlist.length - 1) {
                c.playIndex(0);
              } else {
                c.playIndex(index + 1);
              }
              c.player.play(c.curMedia.source);
            },
            icon: const Icon(CupertinoIcons.forward_fill),
          ),
        ],
      ),
    );
  }
}
