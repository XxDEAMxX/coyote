import 'package:coyote/models/payment_model.dart';

class DebtState {
  final List<PaymentModel> payments;
  DebtState({
    this.payments = const [],
  });

  DebtState copyWith({
    List<PaymentModel>? payments,
  }) {
    return DebtState(
      payments: payments ?? this.payments,
    );
  }
}
