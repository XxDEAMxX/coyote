class ExpenseModel {
  final int? id;
  final String? description;
  final double? amount;
  final DateTime? createAt;

  ExpenseModel({
    this.id,
    this.description,
    this.amount,
    this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'create_at': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
