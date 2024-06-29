class LoanModel {
  final int? id;
  final int? position;
  final String? userId;
  final double? amount;
  final int? quotas;

  LoanModel({
    this.id,
    this.position,
    this.userId,
    this.amount,
    this.quotas,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'user_id': userId,
      'amount': amount,
      'quotas': quotas,
    };
  }
}
