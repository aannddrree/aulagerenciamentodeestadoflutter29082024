import 'package:flutter_riverpod/flutter_riverpod.dart';

// Classe que gerencia o estado do contador
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

// O provedor que será usado para acessar o estado do contador
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
