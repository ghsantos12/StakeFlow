import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Utilitários para trabalhar com valores monetários armazenados como
/// centavos inteiros (int), evitando erros de precisão de ponto flutuante.
class Money {
  Money._();

  static final NumberFormat _brl = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  static final NumberFormat _brlCompact = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 0,
  );

  static final NumberFormat _plainBr = NumberFormat('#,##0.00', 'pt_BR');

  /// Formata centavos para o texto de um campo de valor (sem símbolo de
  /// moeda), usado por [CentsInputFormatter] — ex.: 123456 -> "1.234,56".
  static String formatInput(int cents) => _plainBr.format(cents / 100);

  /// Formata um valor em centavos para string BRL, ex: 12345 -> "R$ 123,45".
  static String format(int cents) {
    return _brl.format(cents / 100);
  }

  /// Formata com sinal explícito (+/-) para uso em indicadores de lucro.
  static String formatSigned(int cents) {
    final formatted = _brl.format(cents.abs() / 100);
    if (cents > 0) return '+$formatted';
    if (cents < 0) return '-$formatted';
    return formatted;
  }

  static String formatCompact(int cents) {
    if (cents.abs() >= 100000 * 100) {
      return _brlCompact.format(cents / 100);
    }
    return format(cents);
  }

  /// Formato bem curto para rótulos de eixo de gráfico: sem símbolo de
  /// moeda, abreviado com "mil"/"mi" para caber no espaço reservado.
  static String formatAxis(int cents) {
    final value = cents / 100;
    final abs = value.abs();
    final sign = value < 0 ? '-' : '';
    final String body;
    if (abs >= 1000000) {
      body = '${(abs / 1000000).toStringAsFixed(1).replaceAll('.', ',')} mi';
    } else if (abs >= 1000) {
      body = '${(abs / 1000).toStringAsFixed(1).replaceAll('.', ',')} mil';
    } else {
      body = abs.round().toString();
    }
    return '$sign$body';
  }

  /// Converte uma string digitada pelo usuário para centavos inteiros.
  /// Aceita tanto o formato brasileiro ("1.234,56") quanto o formato com
  /// ponto decimal simples ("1234.56"): quando ambos separadores aparecem,
  /// assume ponto como separador de milhar e vírgula como decimal; quando
  /// só um deles aparece, ele é tratado como separador decimal. Retorna
  /// null se inválido.
  static int? parseToCents(String input) {
    var cleaned = input.trim().replaceAll(RegExp(r'[^\d,.-]'), '');
    if (cleaned.isEmpty) return null;
    final hasComma = cleaned.contains(',');
    final hasDot = cleaned.contains('.');
    if (hasComma && hasDot) {
      cleaned = cleaned.replaceAll('.', '').replaceAll(',', '.');
    } else if (hasComma) {
      cleaned = cleaned.replaceAll(',', '.');
    }
    final value = double.tryParse(cleaned);
    if (value == null) return null;
    return (value * 100).round();
  }

  /// Converte um double (reais) para centavos, com arredondamento seguro.
  static int fromReais(double reais) => (reais * 100).round();

  static double toReais(int cents) => cents / 100;
}

/// Máscara de valor em dinheiro: cada dígito digitado entra pela direita,
/// como numa calculadora (1 -> "0,01", 12 -> "0,12", 123 -> "1,23"...), em
/// vez de inserir o caractere na posição do cursor sobre o texto já
/// formatado — o que fazia o valor ficar bagunçado ao digitar sobre um
/// campo pré-preenchido com "0,00".
class CentsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (newValue.text.length < oldValue.text.length) {
      final oldDigits = oldValue.text.replaceAll(RegExp(r'\D'), '');
      // Backspace/delete removeu um separador (',' ou '.') em vez de um
      // dígito — remove o último dígito manualmente para o apagar surtir
      // efeito.
      if (digits == oldDigits && digits.isNotEmpty) {
        digits = digits.substring(0, digits.length - 1);
      }
    }
    if (digits.length > 15) digits = digits.substring(digits.length - 15);
    final cents = digits.isEmpty ? 0 : int.parse(digits);
    final formatted = Money.formatInput(cents);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Representa uma odd decimal armazenada com 4 casas decimais de precisão
/// como inteiro (ex: 2.50 -> 25000, 2.1234 -> 21234) para evitar erros de
/// ponto flutuante e preservar odds com mais de 2 casas.
class DecimalOdds {
  DecimalOdds._();

  static const int scale = 10000;

  /// Menor odd válida (1.01), já na escala interna.
  static const int minScaled = scale * 101 ~/ 100;

  static int? parse(String input) {
    final cleaned = input.trim().replaceAll(',', '.');
    if (cleaned.isEmpty) return null;
    final value = double.tryParse(cleaned);
    if (value == null) return null;
    if (value < 1.01) return null;
    return (value * scale).round();
  }

  static double toDouble(int scaled) => scaled / scale;

  /// Formata a odd mostrando no mínimo 2 casas decimais, preservando casas
  /// extras quando a odd foi digitada com mais precisão (ex.: 2,1234).
  static String format(int scaled) {
    final text = toDouble(scaled).toStringAsFixed(4);
    final dotIndex = text.indexOf('.');
    var end = text.length;
    while (end > dotIndex + 3 && text[end - 1] == '0') {
      end--;
    }
    return text.substring(0, end);
  }

  /// Retorno potencial em centavos = stake * odd, arredondado ao centavo
  /// mais próximo (em vez de truncado).
  static int potentialReturn(int stakeCents, int oddsScaled) {
    return (stakeCents * oddsScaled / scale).round();
  }

  /// Odd combinada de uma aposta múltipla = produto das odds decimais de
  /// cada seleção (ex.: 1.80 * 2.10 * 1.50 = 5.67).
  static int combine(Iterable<int> legOddsScaled) {
    var result = 1.0;
    for (final odds in legOddsScaled) {
      result *= odds / scale;
    }
    return (result * scale).round();
  }
}
