import 'package:get/get.dart';
import 'package:ultimate_news/app/backend/binding/account_binding.dart';
import 'package:ultimate_news/app/backend/binding/appearance_binding.dart';
import 'package:ultimate_news/app/backend/binding/comments_binding.dart';
import 'package:ultimate_news/app/backend/binding/contact_binding.dart';
import 'package:ultimate_news/app/backend/binding/details_binding.dart';
import 'package:ultimate_news/app/backend/binding/home_binding.dart';
import 'package:ultimate_news/app/backend/binding/intro_binding.dart';
import 'package:ultimate_news/app/backend/binding/languages_binding.dart';
import 'package:ultimate_news/app/backend/binding/login_binding.dart';
import 'package:ultimate_news/app/backend/binding/pages_binding.dart';
import 'package:ultimate_news/app/backend/binding/register_binding.dart';
import 'package:ultimate_news/app/backend/binding/reset_binding.dart';
import 'package:ultimate_news/app/backend/binding/saved_news_binding.dart';
import 'package:ultimate_news/app/backend/binding/search_binding.dart';
import 'package:ultimate_news/app/backend/binding/single_video_binding.dart';
import 'package:ultimate_news/app/backend/binding/splash_binding.dart';
import 'package:ultimate_news/app/backend/binding/tabs_binding.dart';
import 'package:ultimate_news/app/backend/binding/video_binding.dart';
import 'package:ultimate_news/app/view/account.dart';
import 'package:ultimate_news/app/view/appearance.dart';
import 'package:ultimate_news/app/view/comments.dart';
import 'package:ultimate_news/app/view/contact.dart';
import 'package:ultimate_news/app/view/details.dart';
import 'package:ultimate_news/app/view/home.dart';
import 'package:ultimate_news/app/view/intro.dart';
import 'package:ultimate_news/app/view/languages.dart';
import 'package:ultimate_news/app/view/login.dart';
import 'package:ultimate_news/app/view/pages.dart';
import 'package:ultimate_news/app/view/register.dart';
import 'package:ultimate_news/app/view/reset.dart';
import 'package:ultimate_news/app/view/saved_news.dart';
import 'package:ultimate_news/app/view/search.dart';
import 'package:ultimate_news/app/view/single_video.dart';
import 'package:ultimate_news/app/view/splash.dart';
import 'package:ultimate_news/app/view/tabs.dart';
import 'package:ultimate_news/app/view/video.dart';

class AppRouter {
  static const String homeRoutes = '/';
  static const String accountRoutes = '/account';
  static const String commentsRoutes = '/comments';
  static const String contactsRoutes = '/contacts';
  static const String detailsRoutes = '/details';
  static const String introRoutes = '/intro';
  static const String langaugesRoutes = '/languages';
  static const String loginRoutes = '/login';
  static const String pagesRoutes = '/pages';
  static const String registerRoutes = '/register';
  static const String resetRoutes = '/reset';
  static const String savedNewsRoutes = '/saved_news';
  static const String searchRoutes = '/search';
  static const String splashRoutes = '/splash';
  static const String bottomTabsRoutes = '/bottom_tabs';
  static const String videoRoutes = '/video';
  static const String singleVideoRoutes = '/single_video';
  static const String appearanceRoutes = '/appearance';

  static String getInitialRoute() => homeRoutes;
  static String getAccountRoute() => accountRoutes;
  static String getCommentsRoute() => commentsRoutes;
  static String getContactRoutues() => contactsRoutes;
  static String getDetailsRoutes() => detailsRoutes;
  static String getIntroRoutes() => introRoutes;
  static String getLanguagesRoutes() => langaugesRoutes;
  static String getLoginRoutes() => loginRoutes;
  static String getPageRoutes() => pagesRoutes;
  static String getRegisterRoutes() => registerRoutes;
  static String getResetRoutes() => resetRoutes;
  static String getSavedNewsRoutes() => savedNewsRoutes;
  static String getSearchRoutes() => searchRoutes;
  static String getSplashRoutes() => splashRoutes;
  static String getTabsRoutes() => bottomTabsRoutes;
  static String getVideoRoutes() => videoRoutes;
  static String getSingleVideoRoutes() => singleVideoRoutes;
  static String getAppearanceRoutes() => appearanceRoutes;

  static List<GetPage> routes = [
    GetPage(
        name: homeRoutes,
        page: () => const HomeScreen(),
        binding: HomeBindings()),
    GetPage(
        name: accountRoutes,
        page: () => const AccountScreen(),
        binding: AccountBindings()),
    GetPage(
        name: commentsRoutes,
        page: () => const CommentScreen(),
        binding: CommentsBindings(),
        fullscreenDialog: true),
    GetPage(
        name: contactsRoutes,
        page: () => const ContactScreen(),
        binding: ContactBindings()),
    GetPage(
        name: detailsRoutes,
        page: () => const DetailScreen(),
        binding: DetailsBindings()),
    GetPage(
        name: introRoutes,
        page: () => const IntroScreen(),
        binding: IntroBindings()),
    GetPage(
        name: langaugesRoutes,
        page: () => const LanguageScreen(),
        binding: LanguagesBindings()),
    GetPage(
        name: loginRoutes,
        page: () => const LoginScreen(),
        binding: LoginBindings()),
    GetPage(
        name: pagesRoutes,
        page: () => const PageScreen(),
        binding: PagesBindings()),
    GetPage(
        name: registerRoutes,
        page: () => const RegisterScreen(),
        binding: RegisterBindings()),
    GetPage(
        name: resetRoutes,
        page: () => const ResetScreen(),
        binding: ResetBindings()),
    GetPage(
        name: savedNewsRoutes,
        page: () => const SavedNewsScreen(),
        binding: SavedNewsBindings()),
    GetPage(
        name: searchRoutes,
        page: () => const SearchScreen(),
        binding: SearchBindings()),
    GetPage(
        name: splashRoutes,
        page: () => const SplashScreen(),
        binding: SplashBindings()),
    GetPage(
        name: bottomTabsRoutes,
        page: () => const BottomTabScreen(),
        binding: TabsBindings()),
    GetPage(
        name: videoRoutes,
        page: () => const VideoScreen(),
        binding: VideoBindings()),
    GetPage(
        name: singleVideoRoutes,
        page: () => const SingleVideoScreen(),
        binding: SingleVideoBindings(),
        fullscreenDialog: true),
    GetPage(
        name: appearanceRoutes,
        page: () => const AppearanceScreen(),
        binding: AppearanceBindings())
  ];
}
