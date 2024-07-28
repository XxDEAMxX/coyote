import 'package:coyote/data/loan_database.dart';
import 'package:coyote/modules/new_loan/loan_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanProvider extends StateNotifier<LoanState> {
  LoanProvider() : super(LoanState());

  Future<void> getAllLoans() async {
    state = state.copyWith(loading: true);
    final list = await LoanDatabase.instance.getAllLoans();
    state = state.copyWith(loans: list);
    state = state.copyWith(loading: false);
  }
}

final loanProvider = StateNotifierProvider<LoanProvider, LoanState>((ref) {
  return LoanProvider();
});
