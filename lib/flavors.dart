enum Flavor {
  PROD,
  STAGING,
  DEV,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'Example';
      case Flavor.STAGING:
        return 'Example Staging';
      case Flavor.DEV:
        return 'Example Dev';
      default:
        return 'title';
    }
  }

}
