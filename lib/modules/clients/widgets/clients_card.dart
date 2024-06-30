import 'package:coyote/models/client_model.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientsCard extends StatelessWidget {
  final ClientModel client;
  const ClientsCard({
    required this.client,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        appRouter.push(NewLoanRoute(client: client));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              client.name ?? '-',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
            Text(
              '${client.id ?? '-'}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green,
              ),
            ),
            Text(
              client.address ?? '-',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Text(
                client.phoneNumber ?? '-',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
