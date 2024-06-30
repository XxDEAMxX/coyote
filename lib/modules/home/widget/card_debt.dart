import 'package:coyote/data/client_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDebt extends ConsumerStatefulWidget {
  final LoanModel loan;
  const CardDebt({
    required this.loan,
    super.key,
  });

  @override
  ConsumerState<CardDebt> createState() => _CardDebtState();
}

class _CardDebtState extends ConsumerState<CardDebt> {
  bool loading = false;
  ClientModel? client;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getClients();
    });
  }

  Future<void> getClients() async {
    try {
      loading = true;
      setState(() {});
      client = await ClientDatabase.instance
          .getClient(int.parse(widget.loan.userId!));
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        appRouter.push(DebtRoute(
          loanId: widget.loan.id!,
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: loading
              ? const CircularProgressIndicator()
              : Row(
                  children: [
                    Center(
                      child: Text(
                        '${widget.loan.userId}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client?.name ?? '-',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          client?.address ?? '-',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.white),
                            ),
                          ),
                          child: Text(
                            client?.phoneNumber ?? '-',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Text(
                          'Lunes a Sabado',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.water_drop,
                      color: Colors.greenAccent,
                      size: 60,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
