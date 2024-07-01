import 'package:coyote/models/loan_model.dart';

class LoanState {
  final List<LoanModel> loans;
  final bool loading;
  LoanState({
    this.loans = const [],
    this.loading = false,
  });

  LoanState copyWith({
    List<LoanModel>? loans,
    bool? loading,
  }) {
    return LoanState(
      loans: loans ?? this.loans,
      loading: loading ?? this.loading,
    );
  }
}
