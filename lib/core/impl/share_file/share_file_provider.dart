import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'share_file_impl.dart';

/// Share file Impl provider
final shareFileImplProvider = Provider<ShareFileImpl>(
  (ref) => ShareFileImpl(),
);
