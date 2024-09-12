import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class Cancel extends StatelessWidget {
  final String dong, sex;
  final int floor;
  final String machine;

  Cancel(this.dong, this.floor, this.sex, this.machine, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332,
      height: 109,
      decoration: BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: gray300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 16,
                  decoration: BoxDecoration(color: blue400),
                  alignment: Alignment.center,
                  child: Text(
                    "${dong}동 ${floor}층 ${sex}",
                    style: medium10.copyWith(
                      color: white100,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "${machine}",
                  style: medium14.copyWith(
                    color: gray800,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "${machine}를 취소하시겠습니까?",
                  style: medium8.copyWith(
                    color: gray500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 14, top: 63),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    width: 70,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: gray100,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "아니요",
                      style: medium14.copyWith(
                        color: gray500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 76,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: gray100,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "네",
                      style: medium14.copyWith(
                        color: gray500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
