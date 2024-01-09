import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/parse/theme_mode_parse.dart';

class ThemeModeController extends GetxController implements GetxService {
  final ThemeModeParser parser;
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  ThemeModeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getCurrentTheme();
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    parser.saveTheme(_darkTheme);
    update();
  }

  void getCurrentTheme() async {
    _darkTheme = parser.getSavedTheme();
    update();
  }
}
