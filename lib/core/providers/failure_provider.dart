import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/errors/failures.dart';

/// Failure provider
final failureProvider = StateNotifierProvider<FailureProviderState, Failure?>(
  (ref) => FailureProviderState(),
);

class FailureProviderState extends StateNotifier<Failure?> {
  FailureProviderState() : super(null);
}
