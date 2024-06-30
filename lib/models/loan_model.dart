class LoanModel {
  final int? id;
  final int? position;
  final int? clientId;
  final double? amount;
  final int? quotas;
  final DateTime? createAt;

  LoanModel({
    this.id,
    this.position,
    this.clientId,
    this.amount,
    this.quotas,
    this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'client_id': clientId,
      'amount': amount,
      'quotas': quotas,
      'create_at': createAt?.millisecondsSinceEpoch,
    };
  }
}
