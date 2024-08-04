import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../widget/music_grid.dart';

class AllFilesPage extends GetView<Controller> {
  const AllFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Files'.tr),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: MusicGrid(list: controller.allFiles),
    );
  }
}
