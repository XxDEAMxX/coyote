class LoanModel {
  final int? id;
  final int? position;
  final String? userId;
  final double? amount;
  final int? quotas;
  final DateTime? createAt;

  LoanModel({
    this.id,
    this.position,
    this.userId,
    this.amount,
    this.quotas,
    this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'user_id': userId,
      'amount': amount,
      'quotas': quotas,
      'create_at': createAt?.millisecondsSinceEpoch,
    };
  }
}
