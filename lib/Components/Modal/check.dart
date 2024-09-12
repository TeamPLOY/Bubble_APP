import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class Check extends StatelessWidget {
  final String dong, sex;
  final int floor;
  final double width, height;

  Check(this.dong, this.floor, this.sex,
      {Key? key, this.width = 330, this.height = 72})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (width / 345),
      height: 72,
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
                SizedBox(height: 13),
                Text(
                  "오른쪽 워시타워",
                  style: medium14.copyWith(
                    color: gray800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 17, top: 20), // Padding을 오른쪽에 적용
            child: Container(
              width: 70,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: gray100,
              ),
              alignment: Alignment.center, // 중앙 정렬 추가
              child: Text(
                "사용 완료",
                style: medium14.copyWith(
                  color: gray500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
