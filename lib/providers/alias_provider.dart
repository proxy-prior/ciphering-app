import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_data.dart';

class AliasNotifier extends StateNotifier<List<AliasModel>> {
  AliasNotifier() : super(List.from(MockData.aliases));

  void addAlias(AliasModel alias) {
    state = [...state, alias];
  }

  void removeAlias(int index) {
    state = [...state]..removeAt(index);
  }

  void updateStatus(int index, AliasStatus status) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(status: status) else state[i],
    ];
  }

  void extendExpiry(int index, int days) {
    final alias = state[index];
    final currentExpiry = alias.expiryDate ?? DateTime.now();
    final newExpiry = currentExpiry.add(Duration(days: days));
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(expiryDate: newExpiry) else state[i],
    ];
  }

  void reset() {
    state = List.from(MockData.aliases);
  }

  static String generateAliasNumber() {
    final rng = Random();
    final part1 = (90000 + rng.nextInt(10000)).toString();
    final part2 = (10000 + rng.nextInt(90000)).toString();
    return '+91 $part1 $part2';
  }
}

final aliasProvider =
    StateNotifierProvider<AliasNotifier, List<AliasModel>>((ref) {
  return AliasNotifier();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final statusFilterProvider = StateProvider<AliasStatus?>((ref) => null);

final filteredAliasProvider = Provider<List<AliasModel>>((ref) {
  final aliases = ref.watch(aliasProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final statusFilter = ref.watch(statusFilterProvider);

  var filtered = aliases;

  if (statusFilter != null) {
    filtered = filtered.where((a) => a.status == statusFilter).toList();
  }

  if (query.isNotEmpty) {
    filtered = filtered.where((a) {
      return a.label.toLowerCase().contains(query) ||
          a.number.toLowerCase().contains(query) ||
          (a.purpose?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  return filtered;
});

final aliasStatsProvider = Provider<({int total, int active, int totalCalls})>((ref) {
  final aliases = ref.watch(aliasProvider);
  return (
    total: aliases.length,
    active: aliases.where((a) => a.status == AliasStatus.active).length,
    totalCalls: aliases.fold<int>(0, (sum, a) => sum + a.totalCalls),
  );
});
