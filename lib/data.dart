import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';

class Controller extends GetxController {
  final selectedIndex = 0.obs;
  final pageController = PageController();
  final player = AudioPlayer();
  final playerState = PlayerState.stopped.obs;
  final position = 0.s.obs;
  final duration = 0.s.obs;
  final volume = 1.0.obs;

  bool get isPlaying => playerState() == PlayerState.playing;

  @override
  void onInit() {
    super.onInit();
    player.onPlayerStateChanged.listen((v) => playerState(v));
    player.onDurationChanged.listen((v) => duration(v));
    player.onPositionChanged.listen((v) => position(v));
    ever(volume, (v) => player.setVolume(v));
  }

  @override
  void onClose() {
    player.dispose();
    pageController.dispose();
    super.onClose();
  }

  Function competeUpdate() {
    Function? cleanup;
    return (Function cb) {
      cleanup?.call();
      cb((Function fn) => cleanup = fn);
    };
  }

  Future<void> animateToPage(int index) {
    return pageController.animateToPage(
      index,
      duration: 0.5.s,
      curve: Curves.ease,
    );
  }

  final like = <Media>[
    Media(r'F:\KwDownload\song\鸳鸯戏(DJ版)-郭飞宏.flac'),
    Media(r'F:\KwDownload\song\Dancin(Krono Remix)-Aaron Smith&Luvli.flac'),
    Media(r'F:\KwDownload\song\Lemon-米津玄師.flac'),
    Media(r'F:\KwDownload\song\Payphone(Edit)-Maroon 5&Wiz Khalifa.flac'),
    Media(r'F:\KwDownload\song\Rain-秦基博.flac'),
    Media(r'F:\KwDownload\song\Sea of Tranquility-BeMax.flac'),
    Media(r'F:\KwDownload\song\グランドエスケープ feat.三浦透子-RADWIMPS&三浦透子.flac'),
    Media(r'F:\KwDownload\song\爱人错过-告五人.flac'),
    Media(r'F:\KwDownload\song\愛にできることはまだあるかい-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\大丈夫-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\稻香-周杰伦.flac'),
    Media(r'F:\KwDownload\song\家族の時間-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\暮色回响-吉星出租.flac'),
    Media(r'F:\KwDownload\song\悬溺-葛东琪.flac'),
  ].obs
    ..shuffle();
  final recently = <Media>[
    Media(r'F:\KwDownload\song\鸳鸯戏(DJ版)-郭飞宏.flac'),
    Media(r'F:\KwDownload\song\Dancin(Krono Remix)-Aaron Smith&Luvli.flac'),
    Media(r'F:\KwDownload\song\Lemon-米津玄師.flac'),
    Media(r'F:\KwDownload\song\Payphone(Edit)-Maroon 5&Wiz Khalifa.flac'),
    Media(r'F:\KwDownload\song\Rain-秦基博.flac'),
    Media(r'F:\KwDownload\song\Sea of Tranquility-BeMax.flac'),
    Media(r'F:\KwDownload\song\グランドエスケープ feat.三浦透子-RADWIMPS&三浦透子.flac'),
    Media(r'F:\KwDownload\song\爱人错过-告五人.flac'),
    Media(r'F:\KwDownload\song\愛にできることはまだあるかい-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\大丈夫-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\稻香-周杰伦.flac'),
    Media(r'F:\KwDownload\song\家族の時間-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\暮色回响-吉星出租.flac'),
    Media(r'F:\KwDownload\song\悬溺-葛东琪.flac'),
  ].obs
    ..shuffle();
  final allFiles = <Media>[
    Media(r'F:\KwDownload\song\鸳鸯戏(DJ版)-郭飞宏.flac'),
    Media(r'F:\KwDownload\song\Dancin(Krono Remix)-Aaron Smith&Luvli.flac'),
    Media(r'F:\KwDownload\song\Lemon-米津玄師.flac'),
    Media(r'F:\KwDownload\song\Payphone(Edit)-Maroon 5&Wiz Khalifa.flac'),
    Media(r'F:\KwDownload\song\Rain-秦基博.flac'),
    Media(r'F:\KwDownload\song\Sea of Tranquility-BeMax.flac'),
    Media(r'F:\KwDownload\song\グランドエスケープ feat.三浦透子-RADWIMPS&三浦透子.flac'),
    Media(r'F:\KwDownload\song\爱人错过-告五人.flac'),
    Media(r'F:\KwDownload\song\愛にできることはまだあるかい-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\大丈夫-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\稻香-周杰伦.flac'),
    Media(r'F:\KwDownload\song\家族の時間-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\暮色回响-吉星出租.flac'),
    Media(r'F:\KwDownload\song\悬溺-葛东琪.flac'),
  ].obs
    ..shuffle();
  final playlist = <Media>[
    Media(r'F:\KwDownload\song\鸳鸯戏(DJ版)-郭飞宏.flac'),
    Media(r'F:\KwDownload\song\Dancin(Krono Remix)-Aaron Smith&Luvli.flac'),
    Media(r'F:\KwDownload\song\Lemon-米津玄師.flac'),
    Media(r'F:\KwDownload\song\Payphone(Edit)-Maroon 5&Wiz Khalifa.flac'),
    Media(r'F:\KwDownload\song\Rain-秦基博.flac'),
    Media(r'F:\KwDownload\song\Sea of Tranquility-BeMax.flac'),
    Media(r'F:\KwDownload\song\グランドエスケープ feat.三浦透子-RADWIMPS&三浦透子.flac'),
    Media(r'F:\KwDownload\song\爱人错过-告五人.flac'),
    Media(r'F:\KwDownload\song\愛にできることはまだあるかい-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\大丈夫-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\稻香-周杰伦.flac'),
    Media(r'F:\KwDownload\song\家族の時間-RADWIMPS.flac'),
    Media(r'F:\KwDownload\song\暮色回响-吉星出租.flac'),
    Media(r'F:\KwDownload\song\悬溺-葛东琪.flac'),
  ].obs
    ..shuffle();
  final playIndex = 0.obs;
  Media get curMedia => playlist[playIndex()];
  final loopMode = LoopMode.none.obs;
}

enum LoopMode { none, one, list, random }

class Media {
  final String path;
  late final metadata = MetadataGod.readMetadata(file: path);
  late final lrcPath = p.setExtension(path, '.lrc');
  late final lrc = File(lrcPath).readAsString();
  late final mimeType = lookupMimeType(path);
  late final basename = p.basenameWithoutExtension(path);
  late final title = metadata.then((e) => e.title ?? basename);
  late final artist = metadata.then((e) => e.artist);
  late final type = mimeType?.split('/').elementAtOrNull(0);
  late final cover = metadata.then((e) => e.picture?.data);
  late final source = DeviceFileSource(path);
  late final image = cover.then((e) => e.use((e) => Image.memory(
        e,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
      )));
  Media(this.path);

  @override
  String toString() => path;

  @override
  bool operator ==(Object other) => other is Media && path == other.path;

  @override
  int get hashCode => path.hashCode;
}

extension Use<V> on V? {
  T? use<T>(T Function(V value) fn) => this == null ? null : fn(this as V);
}

extension True on bool {
  T? isTrue<T>(T Function() fn) => this == true ? fn() : null;
  T? isFalse<T>(T Function() fn) => this == false ? fn() : null;
}

extension Num2Duration on num {
  Duration get microseconds => Duration(microseconds: toInt());
  Duration get ms => (this * 1000).microseconds;
  Duration get s => (this * 1000).ms;
  Duration get min => (this * 60).s;
  Duration get hour => (this * 60).min;
  Duration get day => (this * 24).hour;
  Duration get week => (this * 7).day;
}
