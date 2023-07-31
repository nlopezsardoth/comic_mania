import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'comics_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(thisWeekComicsProvider).isEmpty;
  final step2 = ref.watch(lastWeekComicsProvider).isEmpty;
  final step3 = ref.watch(nextWeekComicsProvider).isEmpty;
  final step4 = ref.watch(thisMonthComicsProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false; // finished loading
});
