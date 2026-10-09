import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/date_range.dart';
import '../../providers/data_providers.dart';

/// Barra de chips para selecionar o período de um relatório/gráfico.
/// Reutilizável entre o dashboard e a tela de relatórios, apontando para
/// provedores distintos ([provider]).
class RangeFilterBar extends ConsumerWidget {
  const RangeFilterBar({super.key, required this.provider});

  final NotifierProvider<RangeFilterNotifier, RangeFilterState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final preset in RangePreset.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(preset.label),
                selected: state.preset == preset,
                onSelected: (_) async {
                  if (preset == RangePreset.custom) {
                    final now = DateTime.now();
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime(now.year + 1),
                      initialDateRange: state.custom,
                    );
                    if (picked != null) {
                      ref.read(provider.notifier).setCustom(picked);
                    }
                  } else {
                    ref.read(provider.notifier).setPreset(preset);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
