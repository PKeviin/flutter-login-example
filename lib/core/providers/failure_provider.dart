import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/errors/failures.dart';

/// Failure provider
final failureProvider = StateProvider.autoDispose<Failure?>((ref) => null);
