import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReservationMachinebox extends StatefulWidget {
  final String machine;
  final bool machine_state;
  final bool isActive;
  final VoidCallback onTap;

  const ReservationMachinebox({
    required this.machine,
    required this.isActive,
    required this.machine_state,
    required this.onTap,
    super.key,
  });

  @override
  State<ReservationMachinebox> createState() => _ReservationMachineboxState();
}

class _ReservationMachineboxState extends State<ReservationMachinebox> {
  @override
  Widget build(BuildContext context) {
    // Box decoration and text style setup
    final backgroundColor = widget.machine_state
        ? AppColor.gray300
        : widget.isActive
            ? AppColor.blue400
            : Colors.white;
    final borderColor = widget.machine_state
        ? AppColor.gray300
        : widget.isActive
            ? AppColor.blue400
            : AppColor.gray300;
    final textColor = widget.machine_state
        ? AppColor.gray600
        : widget.isActive
            ? AppColor.white100
            : AppColor.gray700;

    return GestureDetector(
      onTap: widget.machine_state ? null : widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * (160 / 393),
        height: MediaQuery.of(context).size.height * (59 / 852),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.machine_state ? '예약불가' : '세탁기 ${widget.machine}',
            style: AppTextStyles.medium18.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
