/// Consolidates raster image paths used across the app
class AppImagePaths {
  static String root = 'assets';
  static String images = '$root/images';
  static String icons = '$root/icons';

  static String errors = '$images/errors';
  static String flags = '$images/flags';

  // Logo
  static String appLogo = '$icons/icon.png';
  // Error
  static String error = '$icons/error.png';
  static String error404 = '$icons/error_404.png';
  static String errorConnection = '$icons/error_connection.png';
}

/// Consolidates SCG image paths in their own class, hints to the UI to use an SvgPicture to render
class AppSvgPaths {
  static String fingerprint = '${AppImagePaths.images}/fingerprint.svg';
}
