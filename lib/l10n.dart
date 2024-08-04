import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {},
        'zh_CN': {
          'Home': '首页',
          'Like': '喜欢',
          'Recently': '最近播放',
          'All Files': '所有文件',
          'Playlist': '播放列表',
          'Settings': '设置',
          'About': '关于',
          'Error': '错误',
          'Stack Trace': '堆栈追踪',
          'more': '更多',
          'Copied': '复制成功',
        }
      };
}
