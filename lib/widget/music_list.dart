import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../pages/player_page.dart';
import 'music_card.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key, required this.list});

  final RxList<Media> list;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<Controller>();
    return SizedBox(
      height: 220,
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: list.length,
          itemBuilder: (context, index) => MusicCard(
            media: list[index],
            onTap: (heroTag) {
              if (!listEquals(c.playlist, list)) c.playlist(list);
              c.playIndex(index);
              Get.to(() => PlayerPage(heroTag));
              c.player.play(c.curMedia.source);
            },
          ),
        );
      }),
    );
  }
}
