class CurrencyFormatter {
  /// Formats a double value to Indian Rupee currency format
  /// Example: 299.0 -> "₹299"
  /// Example: 299.99 -> "₹299.99"
  static String formatINR(double amount) {
    if (amount == amount.roundToDouble()) {
      return '₹${amount.round()}';
    }
    return '₹${amount.toStringAsFixed(2)}';
  }

  /// Formats currency for display with proper spacing
  /// Example: 299.0 -> "₹ 299"
  static String formatINRWithSpace(double amount) {
    if (amount == amount.roundToDouble()) {
      return '₹ ${amount.round()}';
    }
    return '₹ ${amount.toStringAsFixed(2)}';
  }
}
