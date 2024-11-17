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
    return 
    widget.machine_state? 
    Container(
        width: MediaQuery.of(context).size.width*(160/393),
        height: MediaQuery.of(context).size.height*(59/852),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // #000000 15%
              offset: const Offset(0, 3), // x: 0, y: 3
              blurRadius: 3,       // blur: 3
            ),
          ],
          border: Border.all(
            color: AppColor.red200
          ),
          borderRadius: BorderRadius.circular(10),
          color:AppColor.gray100,
        ),
        child: Center(
          child: Text('예약불가',style: AppTextStyles.medium18.copyWith(color: AppColor.red200),),
    )):
    GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width*(150/393),
        height: MediaQuery.of(context).size.height*(59/852),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // #000000 15%
              offset: const Offset(0, 3), // x: 0, y: 3
              blurRadius: 3,       // blur: 3
            ),
          ],
          border: Border.all(
            color: widget.isActive? AppColor.blue400 : AppColor.gray300
          ),
          borderRadius: BorderRadius.circular(10),
          color:AppColor.gray100,
        ),
        child: Center(
          child: Text('세탁기 ${widget.machine}',style: AppTextStyles.medium18.copyWith(color: widget.isActive? AppColor.blue400 : AppColor.gray700),),
        ),
      ),
    );
  }
}