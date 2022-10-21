import '../../utils/platform/platform.dart';

abstract class PackageInfoRepository {
  Future<void> initPackageInfo(Platform platformBase);
  Future<void> getVersion();
  Future<void> getBuildNumber();
  void getPlatform(Platform platformBase);
}
