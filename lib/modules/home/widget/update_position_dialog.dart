import 'package:coyote/data/loan_database.dart';
import 'package:coyote/modules/new_loan/loan_provider.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePositionDialog extends ConsumerStatefulWidget {
  final int id;
  const UpdatePositionDialog({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<UpdatePositionDialog> createState() =>
      _UpdatePositionDialogState();
}

class _UpdatePositionDialogState extends ConsumerState<UpdatePositionDialog> {
  final _positionController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 0.25.sh,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 25.h),
          child: loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Actualizar Posicion',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SsTextInput(
                      controller: _positionController,
                      hintText: 'ej. 1',
                      onChanged: (value) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    SsButton(
                      text: 'Actualizar',
                      onTap: () async {
                        await updatePosition();
                      },
                    )
                  ],
                )),
    );
  }

  Future<void> updatePosition() async {
    if (_positionController.text.isEmpty) {
      SsNotification.warning('Ingresa una posicion');
      return;
    }
    try {
      loading = true;
      setState(() {});
      final position = int.parse(_positionController.text);
      await LoanDatabase.instance.updatePosition(widget.id, position);
      await ref.read(loanProvider.notifier).getAllLoans();
      appRouter.maybePop();
    } catch (e) {
      SsNotification.error('Error al actualizar la posicion');
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }
}
