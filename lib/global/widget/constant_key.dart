enum AppConstantKey {
  fontFamily
}

extension AppConstantExtention on AppConstantKey {
  String get key {
    switch (this) {
      case AppConstantKey.fontFamily:
        return 'Poppins';

      default:
        return "";
    }
  }
}
