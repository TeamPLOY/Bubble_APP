import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/data/models/notice_detail_model.dart';
import 'package:bubble_app/data/providers/network/apis/notice/notice_detail_api.dart';

class NoticeDetailPage extends StatefulWidget {
  final int items;
  const NoticeDetailPage({required this.items, Key? key}) : super(key: key);

  @override
  State<NoticeDetailPage> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NoticeDetailPage> {
  List<NoticeDetailModel> notifidetaillist = [];
  bool isLoading = true; // 로딩 상태를 추가합니다.

  @override
  void initState() {
    super.initState();
    getnotifi();
  }

  void getnotifi() async {
    NoticeDetailApi notification = NoticeDetailApi();
    notifidetaillist = await notification.fetchNotificationDetail();
    setState(() {
      isLoading = false; // 데이터 가져온 후 로딩 상태를 업데이트합니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100, // 색상 변경
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideHeader(text: '공지사항'),
            SizedBox(height: 65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: isLoading // 로딩 상태에 따라 UI 변경
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('로딩 중',
                            style: AppTextStyles.semiBold14
                                .copyWith(color: AppColor.gray800)),
                        SizedBox(height: 4),
                        Text('로딩 중',
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColor.gray500)),
                        SizedBox(height: 31),
                        Text('로딩 중',
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColor.gray800)),
                      ],
                    )
                  : notifidetaillist.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${notifidetaillist[widget.items].title}',
                                style: AppTextStyles.semiBold14
                                    .copyWith(color: AppColor.gray800)),
                            SizedBox(height: 4),
                            Text('${notifidetaillist[widget.items].date}',
                                style: AppTextStyles.regular14
                                    .copyWith(color: AppColor.gray500)),
                            SizedBox(height: 31),
                            Text('${notifidetaillist[widget.items].detail}',
                                style: AppTextStyles.regular12
                                    .copyWith(color: AppColor.gray800)),
                          ],
                        )
                      : Text('공지사항이 없습니다.',
                          style: AppTextStyles.regular12.copyWith(
                              color: AppColor.gray800)), // 비어 있을 경우 메시지 추가
            ),
          ],
        ),
      ),
    );
  }
}
