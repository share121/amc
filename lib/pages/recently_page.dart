import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../widget/music_grid.dart';

class RecentlyPage extends GetView<Controller> {
  const RecentlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently'.tr),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: MusicGrid(list: controller.recently),
    );
  }
}
