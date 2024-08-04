import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:window_manager/window_manager.dart';
import 'package:system_theme/system_theme.dart';

import 'data.dart';
import 'l10n.dart';
import 'widget/ctrl_bar.dart';
import 'widget/github_button.dart';
import 'widget/window_buttons.dart';
import 'pages/home_page.dart';
import 'pages/playlist_page.dart';
import 'pages/recently_page.dart';
import 'pages/all_files_page.dart';
import 'pages/like_page.dart';

final isDesktop = !kIsWeb && GetPlatform.isDesktop;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MetadataGod.initialize();
  if (isDesktop) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  SystemTheme.fallbackColor = Colors.blue;
  await SystemTheme.accentColor.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return SystemThemeBuilder(builder: (context, accent) {
      return GetMaterialApp(
        title: 'AMC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: accent.accent),
          fontFamily: 'MiSans',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: accent.accent,
            brightness: Brightness.dark,
          ),
          fontFamily: 'MiSans',
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],
        // themeMode: ThemeMode.light,
        translations: Messages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

final destinations = [
  NavigationRailDestination(
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home),
    label: Text('Home'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.favorite_border),
    selectedIcon: const Icon(Icons.favorite),
    label: Text('Like'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.history_outlined),
    selectedIcon: const Icon(Icons.history),
    label: Text('Recently'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.list),
    selectedIcon: const Icon(Icons.list),
    label: Text('Playlist'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.computer_outlined),
    selectedIcon: const Icon(Icons.computer),
    label: Text('All Files'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.settings_outlined),
    selectedIcon: const Icon(Icons.settings),
    label: Text('Settings'.tr),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.info_outline),
    selectedIcon: const Icon(Icons.info),
    label: Text('About'.tr),
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<Controller>();
    return Scaffold(
      appBar: AppBar(
        title: isDesktop
            ? const DragToMoveArea(child: Text('AMC'))
            : const Text('AMC'),
        flexibleSpace: isDesktop
            .isTrue(() => const DragToMoveArea(child: SizedBox.expand())),
        actions: [
          const GithubButton(),
          const SizedBox(width: 8),
          if (isDesktop) const WindowButtons(),
        ],
        elevation: 4,
      ),
      body: SafeArea(
        child: Row(
          children: [
            LayoutBuilder(builder: (context, con) {
              return SingleChildScrollView(
                clipBehavior: Clip.none,
                child: SizedBox(
                  height: max(con.maxHeight, 336),
                  child: Obx(() {
                    return NavigationRail(
                      destinations: destinations,
                      selectedIndex: c.selectedIndex(),
                      onDestinationSelected: (index) => c.animateToPage(index),
                      labelType: con.maxHeight > 455
                          ? NavigationRailLabelType.all
                          : NavigationRailLabelType.selected,
                    );
                  }),
                ),
              );
            }),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: c.pageController,
                      scrollDirection: Axis.vertical,
                      onPageChanged: c.selectedIndex.call,
                      children: [
                        const HomePage(),
                        const LikePage(),
                        const RecentlyPage(),
                        const PlaylistPage(),
                        const AllFilesPage(),
                        Center(child: Text('Settings'.tr)),
                        Center(child: Text('About'.tr)),
                      ],
                    ),
                  ),
                  const CtrlBar(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
