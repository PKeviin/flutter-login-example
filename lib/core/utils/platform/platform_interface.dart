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
  final bool isWeb;
  final bool isIOS;
  final bool isAndroid;
  final bool isWindows;
  final bool isLinux;
  final bool isMacOS;

  final String operatingSystem;

  bool get isDesktop => isWindows || isMacOS || isLinux;
  bool get isModbile => isIOS || isAndroid;
}
