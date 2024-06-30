class PaymentModel {
  final int? id;
  final int? loanId;
  final int? quotaNumber;
  final DateTime? datePayment;
  final double? amountPaid;
  final double? amountToBePaid;
  final DateTime? updatedAt;

  PaymentModel({
    this.id,
    this.loanId,
    this.quotaNumber,
    this.datePayment,
    this.amountPaid,
    this.amountToBePaid,
    this.updatedAt,
  });

  PaymentModel copyWith({
    int? quotaNumber,
    DateTime? datePayment,
    double? amountPaid,
    double? amountToBePaid,
    DateTime? updatedAt,
  }) =>
      PaymentModel(
        id: id ?? id,
        loanId: loanId,
        quotaNumber: quotaNumber ?? this.quotaNumber,
        datePayment: datePayment ?? this.datePayment,
        amountPaid: amountPaid ?? this.amountPaid,
        amountToBePaid: amountToBePaid ?? this.amountToBePaid,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toMap() {
    return {
      'loan_id': loanId,
      'quota_number': quotaNumber,
      'date_payment': datePayment?.millisecondsSinceEpoch,
      'amount_paid': amountPaid,
      'amount_to_be_paid': amountToBePaid,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMapPaid() {
    return {
      'amount_paid': amountPaid,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMapAll(int quota) {
    return {
      'loan_id': loanId,
      'quota_number': quota + 1,
      'date_payment':
          DateTime.now().add(Duration(days: quota)).millisecondsSinceEpoch,
      'amount_paid': amountPaid,
      'amount_to_be_paid': amountToBePaid,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }
}
