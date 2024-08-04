import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../widget/music_grid.dart';

class LikePage extends GetView<Controller> {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Like'.tr),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: MusicGrid(list: controller.like),
    );
  }
}
