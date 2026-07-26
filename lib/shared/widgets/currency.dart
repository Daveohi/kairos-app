/// Formats [amount] as a Naira amount, e.g. `formatNaira(45000)` → `"₦45,000"`.
String formatNaira(double amount) {
  final whole = amount.round();
  final digits = whole.abs().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    final remaining = digits.length - i;
    if (i > 0 && remaining % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }

  return '${whole < 0 ? '-' : ''}₦$buffer';
}
