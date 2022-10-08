import 'dart:io' as io show Platform;

import 'platform_interface.dart';

class Platform extends PlatformInterface {
  Platform()
      : super(
          isAndroid: io.Platform.isAndroid,
          isIOS: io.Platform.isIOS,
          isLinux: io.Platform.isLinux,
          isMacOS: io.Platform.isMacOS,
          isWindows: io.Platform.isWindows,
          operatingSystem: io.Platform.operatingSystem,
        );
}
