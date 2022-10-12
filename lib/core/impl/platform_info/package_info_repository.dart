abstract class PackageInfoRepository {
  Future<void> initPackageInfo();
  Future<void> getVersion();
  Future<void> getBuildNumber();
  void getPlatform();
}
