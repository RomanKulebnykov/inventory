import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._internal();

  static String currencyFormatter(double value) {
    return NumberFormat.decimalPatternDigits(decimalDigits: 2).format(value);
  }

  static final DateFormat dateFormat = DateFormat('d.M.y');
  static final DateFormat timeFormat = DateFormat('HH:mm');
}

class TextInputCurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final number = double.tryParse(newValue.text);
    if (number != null) {
      final formattedValue = AppFormatter.currencyFormatter(number);
      return TextEditingValue(
        text: formattedValue,
        selection: newValue.selection,
      );
    } else {
      return oldValue;
    }
  }
}
