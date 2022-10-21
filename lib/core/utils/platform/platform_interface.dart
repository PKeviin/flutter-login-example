abstract class PlatformInterface {
  PlatformInterface({
    this.isWeb = false,
    this.isIOS = false,
    this.isAndroid = false,
    this.isWindows = false,
    this.isLinux = false,
    this.isMacOS = false,
    this.operatingSystem = '',
  });
  bool isWeb;
  bool isIOS;
  bool isAndroid;
  bool isWindows;
  bool isLinux;
  bool isMacOS;

  final String operatingSystem;

  bool get isDesktop => isWindows || isMacOS || isLinux;
  bool get isMobile => isIOS || isAndroid;
}
