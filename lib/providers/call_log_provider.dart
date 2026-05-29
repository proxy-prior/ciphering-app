import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_data.dart';

class CallLogNotifier extends StateNotifier<List<CallLogModel>> {
  CallLogNotifier() : super(List.from(MockData.callLogs));

  void blockNumber(String callerNumber) {
    state = [
      for (final log in state)
        if (log.callerNumber == callerNumber)
          log.copyWith(status: CallStatus.blocked, isBlocked: true)
        else
          log,
    ];
  }

  void saveContact(String callerNumber, String name) {
    state = [
      for (final log in state)
        if (log.callerNumber == callerNumber)
          log.copyWith(callerName: name, isSaved: true)
        else
          log,
    ];
  }

  void reportSpam(String callerNumber) {
    blockNumber(callerNumber);
  }

  void clearAll() {
    state = [];
  }

  void reset() {
    state = List.from(MockData.callLogs);
  }
}

final callLogProvider =
    StateNotifierProvider<CallLogNotifier, List<CallLogModel>>((ref) {
  return CallLogNotifier();
});

final callFilterProvider = StateProvider<String>((ref) => 'All');

final filteredCallLogProvider = Provider<List<CallLogModel>>((ref) {
  final logs = ref.watch(callLogProvider);
  final filter = ref.watch(callFilterProvider);

  switch (filter) {
    case 'Missed':
      return logs.where((c) => c.status == CallStatus.missed).toList();
    case 'Spam':
      return logs.where((c) => c.status == CallStatus.blocked).toList();
    case 'Saved':
      return logs.where((c) => c.isSaved).toList();
    default:
      return logs;
  }
});
