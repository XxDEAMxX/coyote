import 'package:coyote/data/client_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/modules/home/widget/update_position_dialog.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_card.dart';
import 'package:coyote/widgets/ss_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
      client = await ClientDatabase.instance.getClient(widget.loan.clientId!);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(widget.loan.id);
        SsDialog.show(
          context: context,
          content: UpdatePositionDialog(id: widget.loan.id!),
        );
      },
      onTap: () {
        appRouter.push(DebtRoute(
          loanId: widget.loan.id!,
        ));
      },
      child: SsCard(
        backgroundColor: Colors.black,
        child: loading
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  Center(
                    child: Text(
                      '${widget.loan.position}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '${client?.name}',
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          '${client?.address}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _makePhoneCall(client!.phoneNumber!);
                          },
                          child: Text(
                            '${client?.phoneNumber}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.loan.workDays}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: Colors.greenAccent,
                        size: 60.sp,
                      ),
                      Text(
                        'cod: ${widget.loan.id}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
