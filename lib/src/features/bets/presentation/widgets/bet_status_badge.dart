import 'package:flutter/material.dart';
import '../../../../domain/models/enums.dart';

String betStatusLabel(BetStatus status) {
  switch (status) {
    case BetStatus.open:
      return 'Em aberto';
    case BetStatus.won:
      return 'Ganha';
    case BetStatus.lost:
      return 'Perdida';
    case BetStatus.voided:
      return 'Anulada';
    case BetStatus.cashedOut:
      return 'Cashout';
  }
}

Color betStatusColor(BetStatus status) {
  switch (status) {
    case BetStatus.open:
      return const Color(0xFFF5A623);
    case BetStatus.won:
      return const Color(0xFF16A34A);
    case BetStatus.lost:
      return const Color(0xFFDC2626);
    case BetStatus.voided:
      return const Color(0xFF9CA3AF);
    case BetStatus.cashedOut:
      return const Color(0xFF2563EB);
  }
}

class BetStatusBadge extends StatelessWidget {
  const BetStatusBadge({super.key, required this.status});

  final BetStatus status;

  @override
  Widget build(BuildContext context) {
    final color = betStatusColor(status);
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class BetStatusChip extends StatelessWidget {
  const BetStatusChip({super.key, required this.status});

  final BetStatus status;

  @override
  Widget build(BuildContext context) {
    final color = betStatusColor(status);
    return Chip(
      label: Text(betStatusLabel(status), style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
