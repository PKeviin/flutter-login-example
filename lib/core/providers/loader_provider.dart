import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loader provider
final loaderProvider = StateNotifierProvider<LoaderProviderState, bool>(
  (ref) => LoaderProviderState(),
);

class LoaderProviderState extends StateNotifier<bool> {
  LoaderProviderState() : super(false);
}
