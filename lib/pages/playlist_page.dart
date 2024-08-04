import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../widget/music_grid.dart';

class PlaylistPage extends GetView<Controller> {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'.tr),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: MusicGrid(list: controller.playlist),
    );
  }
}
