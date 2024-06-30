import 'package:coyote/data/payments_database.dart';
import 'package:coyote/modules/debt/debt_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebtNotifier extends StateNotifier<DebtState> {
  DebtNotifier() : super(DebtState());

  Future<void> getPayments({required int loanId}) async {
    final list = await PaymentsDatabase.instance.getPaymentByLoanId(loanId);
    state = state.copyWith(
      payments: list,
    );
  }
}

final debtProvider = StateNotifierProvider<DebtNotifier, DebtState>((ref) {
  return DebtNotifier();
});
