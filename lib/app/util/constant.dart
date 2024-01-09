import 'package:ultimate_news/app/backend/models/languages_model.dart';
import 'package:ultimate_news/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const double defaultTitleSize = 12;
  static const double defaultDescriptionSize = 12;
  static const double defaultContentSize = 12;

  static const String defaultLanguageApp = 'en';

  // Admob Creds
  static const String androidBannerId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String ioSBannerId = 'ca-app-pub-3940256099942544/2934735716';
  static const String androidInterId = 'ca-app-pub-3940256099942544/1033173712';
  static const String iosInterId = 'ca-app-pub-3940256099942544/4411468910';
  // Admob Creds

  // API Routes
  static const String allCategories = 'api/v1/categories/getCategoriesForUser';
  static const String banners = 'api/v1/banners/userBanners';
  static const String newsByCateId = 'api/v1/users/getByCate';
  static const String videoNews = 'api/v1/news/getVideoNews';
  static const String searchQuery = 'api/v1/news/searchQuery';
  static const String getById = 'api/v1/news/getByNewsId';
  static const String relatedNews = 'api/v1/news/getRelate';
  static const String register = 'api/v1/auth/create_account';
  static const String login = 'api/v1/auth/login';
  static const String logout = 'api/v1/auth/logout';
  static const String saveLikes = 'api/v1/news/saveLike';
  static const String deleteLikes = 'api/v1/news/deleteLike';
  static const String saveNews = 'api/v1/news/saveNews';
  static const String deleteSaved = 'api/v1/news/deleteSaved';
  static const String savedNews = 'api/v1/news/getSavedNews';
  static const String sendEmailForReset = 'api/v1/users/emailExist';
  static const String verifyOTPRequest = 'api/v1/otp/verifyOTP';
  static const String updatePasswordRequest =
      'api/v1/updateUserPasswordWithEmail';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String saveToken = 'api/v1/saveToken';
  static const String saveComments = 'api/v1/comment/create';
  static const String getComments = 'api/v1/comment/getByNewsId';
  // API Routes

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en',
        tts: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'عربي',
        countryCode: 'AE',
        languageCode: 'ar',
        tts: 'ar-SA'),
    LanguageModel(
        imageUrl: '',
        languageName: 'हिन्दी',
        countryCode: 'IN',
        languageCode: 'hi',
        tts: 'hi-In'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Español',
        countryCode: 'De',
        languageCode: 'es',
        tts: 'es-ES'),
  ];
}

// Support Text to Speech Languages

// en-GB, en-US, it-IT, sv-SE, 
// fr-CA, de-DE, he-IL, id-ID, es-AR,
// nl-BE, en, ro-RO, pt-PT, es-ES, es-MX,
// th-TH, en-AU, ja-JP, sk-SK, hi-IN,
// pt-BR, ar-SA, hu-HU, zh-TW, el-GR,
// ru-RU, en-IE, nb-NO, en-IN, da-DK,
// fi-FI, zh-HK, en-ZA,
// fr-FR, zh-CN, nl-NL, tr-TR,
// ko-KR, pl-PL, cs-CZ, es-US

// Support Text to Speech Languages