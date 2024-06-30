import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/modules/debt/debt_provider.dart';
import 'package:coyote/modules/debt/widget/card_payments.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DebtPage extends ConsumerStatefulWidget {
  final int loanId;
  const DebtPage({
    required this.loanId,
    super.key,
  });

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
      loading = true;
      setState(() {});
      loan = await LoanDatabase.instance.getLoanById(widget.loanId);
      await ref.read(debtProvider.notifier).getPayments(loanId: loan!.id!);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      if (mounted){
      setState(() {});
    }}
  }

  @override
  Widget build(BuildContext context) {
    final List<PaymentModel> payments =
        ref.watch(debtProvider.select((value) => value.payments));
    final double totalAmountPaid =
        payments.fold(0, (sum, item) => sum + item.amountPaid!);
    final double balance = (loan?.amount ?? 0) - (totalAmountPaid);
    final int toPay = payments.indexWhere(
      (element) => element.amountToBePaid != element.amountPaid,
    );
    final bool paid = payments.any((element) =>
        DateTimeExtension().toHumanize(element.updatedAt) ==
        DateTimeExtension().toHumanize(DateTime.now()));
    return SsScaffold(
      title: 'Pagos',
      body: loading
          ? const CircularProgressIndicator()
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total Venta: ',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Text(
                              '${loan?.amount}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Salgo Venta:',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Text(
                              '$balance',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Codigo:',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Text(
                              '${loan?.id}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Fecha Venta:',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Text(
                              DateTimeExtension().toHumanize(loan?.createAt),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CardPayments(
                        payment: payments[index],
                        toPay: index == toPay && !paid,
                      );
                    },
                    itemCount: payments.length,
                  ),
                ),
              ],
            ),
    );
  }
}
