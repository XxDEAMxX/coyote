import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/modules/debt/debt_provider.dart';
import 'package:coyote/modules/debt/widget/card_payments.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/widgets/ss_app_bar.dart';

@RoutePage()
class DebtPage extends ConsumerStatefulWidget {
  final int loanId;

  const DebtPage({
    required this.loanId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends ConsumerState<DebtPage>
    with AutomaticKeepAliveClientMixin {
  LoanModel? loan;
  bool loading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getLoans();
    });
  }

  Future<void> getLoans() async {
    try {
      setState(() => loading = true);
      loan = await LoanDatabase.instance.getLoanById(widget.loanId);
      await ref.read(debtProvider.notifier).getPayments(loanId: loan!.id!);
    } catch (e) {
      print('Error fetching loans: $e');
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final payments = ref.watch(debtProvider.select((value) => value.payments));
    final totalAmountPaid =
        payments.fold<double>(0, (sum, item) => sum + (item.amountPaid ?? 0));
    final balance = (loan?.amount ?? 0) - totalAmountPaid;

    return SsScaffold(
      title: 'Pagos',
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  padding:
                      EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 5.h),
                  child: Column(
                    children: [
                      _buildRow(
                          'Total Venta:', loan?.amount.toString() ?? 'N/A'),
                      _buildRow('Saldo Venta:', balance.toString()),
                      _buildRow('Codigo:', loan?.id.toString() ?? 'N/A'),
                      _buildRow('Fecha Venta:',
                          DateTimeExtension().toHumanize(loan?.createAt)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: payments.map((e) {
                        final toPay = e.amountToBePaid != e.amountPaid;
                        final paid =
                            DateTimeExtension().toHumanize(e.updatedAt) ==
                                DateTimeExtension().toHumanize(DateTime.now());
                        return CardPayments(
                          payment: e,
                          toPay: toPay && !paid,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
