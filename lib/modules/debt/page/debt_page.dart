import 'package:coyote/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/modules/debt/debt_provider.dart';
import 'package:coyote/modules/debt/widget/card_payments.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/widgets/ss_scaffold.dart';

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

class _DebtPageState extends ConsumerState<DebtPage> {
  LoanModel? loan;
  bool loading = false;

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
    final payments = ref.watch(debtProvider.select((value) => value.payments));
    final totalAmountPaid =
        payments.fold<double>(0, (sum, item) => sum + (item.amountPaid ?? 0));
    final balance = (loan?.amount ?? 0) - totalAmountPaid;
    final int toPay = payments.indexWhere(
      (element) => element.amountToBePaid != element.amountPaid,
    );
    final bool paid = payments.any((element) =>
        DateTimeExtension().toHumanize(element.updatedAt) ==
        DateTimeExtension().toHumanize(DateTime.now()));
    return SsScaffold(
      onBack: () {
        appRouter.back();
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading)
            Center(child: CircularProgressIndicator())
          else ...[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 5.h),
              child: Column(
                children: [
                  _buildRow('Total Venta:', loan?.amount.toString() ?? 'N/A'),
                  _buildRow('Saldo Venta:', balance.toString()),
                  _buildRow('Codigo:', loan?.id.toString() ?? 'N/A'),
                  _buildRow('Fecha Venta:',
                      DateTimeExtension().toHumanize(loan?.createAt)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CardPayments(
                    payment: payments[index],
                    toPay: toPay == index && !paid,
                  );
                },
                itemCount: payments.length,
              ),
            ),
          ]
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
