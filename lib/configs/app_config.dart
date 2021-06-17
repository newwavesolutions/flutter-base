class AppConfig {
  static const String appId = 'it.thoson';
  static const String appName = 'Flutter Demo';
  static const String version = '1.0.0';

  ///Network
  static const baseUrl = "https://api.themoviedb.org/3";

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';

  ///DateFormat
  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeAPIFormat = "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Arimo';
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}

class MovieAPIConfig {
  static const String APIKey = '26763d7bf2e94098192e629eb975dab0';
}
