enum Flavor {
  PROD,
  DEV,
  UAT,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'HRM App';
      case Flavor.DEV:
        return 'HRM App Dev';
      case Flavor.UAT:
        return 'HRM App Uat';
      default:
        return 'title';
    }
  }

  static String get getApiURL {
    switch (appFlavor) {
      case Flavor.PROD:
        return '';
      case Flavor.DEV:
        return '';
      case Flavor.UAT:
        return '';
      default:
        return '';
    }
  }

  static String get getSSOURL {
    switch (appFlavor) {
      case Flavor.PROD:
        return '';
      case Flavor.DEV:
        return '';
      case Flavor.UAT:
        return '';
      default:
        return '';
    }
  }
}
