import 'package:flutter/material.dart';
import '../../../../domain/models/enums.dart';

String movementTypeLabel(MovementType type) {
  switch (type) {
    case MovementType.externalDeposit:
      return 'Depósito externo';
    case MovementType.externalWithdrawal:
      return 'Retirada externa';
    case MovementType.depositToBookmaker:
      return 'Depósito em casa de apostas';
    case MovementType.withdrawalFromBookmaker:
      return 'Saque de casa de apostas';
    case MovementType.transferBetweenAccounts:
      return 'Transferência entre contas';
    case MovementType.adjustment:
      return 'Ajuste de saldo';
  }
}

IconData movementTypeIcon(MovementType type) {
  switch (type) {
    case MovementType.externalDeposit:
      return Icons.add_circle_outline;
    case MovementType.externalWithdrawal:
      return Icons.remove_circle_outline;
    case MovementType.depositToBookmaker:
      return Icons.north_east;
    case MovementType.withdrawalFromBookmaker:
      return Icons.south_west;
    case MovementType.transferBetweenAccounts:
      return Icons.swap_horiz;
    case MovementType.adjustment:
      return Icons.tune;
  }
}
