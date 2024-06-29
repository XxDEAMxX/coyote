import 'package:coyote/models/loan_model.dart';

class LoanState {
  final List<LoanModel> loans;
  LoanState({
    this.loans = const [],
  });

  LoanState copyWith({
    List<LoanModel>? loans,
  }) {
    return LoanState(
      loans: loans ?? this.loans,
    );
  }
}
