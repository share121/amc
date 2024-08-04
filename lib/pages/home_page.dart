import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/header.dart';
import '../widget/music_list.dart';
import '../data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<Controller>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'.tr),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              'Like'.tr,
              btnChild: Text('more'.tr),
              onPressed: () => c.animateToPage(1),
            ),
            MusicList(list: c.like),
            Header(
              'Recently'.tr,
              btnChild: Text('more'.tr),
              onPressed: () => c.animateToPage(2),
            ),
            MusicList(list: c.recently),
            Header(
              'Playlist'.tr,
              btnChild: Text('more'.tr),
              onPressed: () => c.animateToPage(3),
            ),
            MusicList(list: c.playlist),
            Header(
              'All Files'.tr,
              btnChild: Text('more'.tr),
              onPressed: () => c.animateToPage(4),
            ),
            MusicList(list: c.allFiles),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
