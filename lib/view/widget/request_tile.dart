import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

class AcceptRejectListTile extends StatelessWidget {
  final String name;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AcceptRejectListTile({
    Key? key,
    required this.name,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(fontSize: 4.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              height: 8.h,
              width: 10.w,
              textStyle: TextStyle(fontSize: 3.sp, color: AppColors.white),
              text: "Accept",
              onTap: onAccept,
            ),
            const SizedBox(width: 8),
            CustomButton(
              color: AppColors.red,
              height: 8.h,
              width: 10.w,
              textStyle: TextStyle(fontSize: 3.sp, color: AppColors.white),
              text: "Reject",
              onTap: onReject,
            ),
          ],
        ),
      ),
    );
  }
}
