import 'package:flutter/material.dart';
import '../../../../domain/models/enums.dart';

Color creditCardBillStatusColor(CreditCardBillStatus status) {
  switch (status) {
    case CreditCardBillStatus.open:
      return const Color(0xFF2563EB);
    case CreditCardBillStatus.closed:
      return const Color(0xFFF59E0B);
    case CreditCardBillStatus.partiallyPaid:
      return const Color(0xFF7C3AED);
    case CreditCardBillStatus.paid:
      return const Color(0xFF16A34A);
    case CreditCardBillStatus.overdue:
      return const Color(0xFFDC2626);
  }
}

Color billStatusColor(BillStatus status) {
  switch (status) {
    case BillStatus.pending:
      return const Color(0xFF2563EB);
    case BillStatus.paid:
      return const Color(0xFF16A34A);
    case BillStatus.partiallyPaid:
      return const Color(0xFF7C3AED);
    case BillStatus.overdue:
      return const Color(0xFFDC2626);
    case BillStatus.cancelled:
      return const Color(0xFF9CA3AF);
  }
}
