// coverage:ignore-file
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DecimalFormatter extends TextInputFormatter {
  DecimalFormatter({this.decimalDigits = 2})
      : assert(
  decimalDigits >= 0,
  'decimalDigits cannot be less than 0',
  );
  final int decimalDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: const TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split('.').length > 2) ||
          (newText.split('.')[1].length > decimalDigits)) {
        return oldValue;
      } else {
        return newValue;
      }
    }

    //in case if input is empty or zero
    if (newText.trim() == '') {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else if (int.parse(newText) < 0) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    final newDouble = double.parse(newText);
    final selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    final newString = NumberFormat('#,##0.##').format(newDouble);

    final newSelectionIndex = newString.length - selectionIndexFromTheRight;
    final selection = TextSelection(
      baseOffset: newSelectionIndex < 0 ? 0 : newSelectionIndex,
      extentOffset: newSelectionIndex < 0 ? 0 : newSelectionIndex,
    );

    return TextEditingValue(
      text: newString,
      selection: selection,
    );
  }
}
