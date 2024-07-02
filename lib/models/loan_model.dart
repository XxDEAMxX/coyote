class LoanModel {
  final int? id;
  final int? position;
  final int? clientId;
  final double? amount;
  final int? quotas;
  final DateTime? createAt;
  final String? workDays;

  LoanModel({
    this.id,
    this.position,
    this.clientId,
    this.amount,
    this.quotas,
    this.createAt,
    this.workDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'client_id': clientId,
      'amount': amount,
      'quotas': quotas,
      'create_at': createAt?.millisecondsSinceEpoch,
      'work_days': workDays,
    };
  }
}
