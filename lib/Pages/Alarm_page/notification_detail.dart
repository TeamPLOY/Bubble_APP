import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Utils/notification_detail.dart';
import 'package:bubble_app/Models/notification_detail_models.dart';

class NotificationDetail extends StatefulWidget {
  final int items;
  const NotificationDetail({required this.items, super.key});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {  
  List<NotificationDetailModels> notifidetaillist = [];
  
  @override
  void initState()  {
    super.initState();
    getnotifi();
  }

  void getnotifi() async {
    NotificationDetail_get notification = NotificationDetail_get();
    notifidetaillist = await notification.fetchNotificationDetail();
    setState(() {}); // 데이터를 가져온 후 UI를 업데이트합니다.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(text: '공지사항'),
            SizedBox(height: 65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: notifidetaillist.isNotEmpty // 리스트가 비어 있지 않은지 확인합니다.
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${notifidetaillist[widget.items].title}', style: semiBold14.copyWith(color: gray800)),
                      SizedBox(height: 4),
                      Text('${notifidetaillist[widget.items].date}', style: regular14.copyWith(color: gray500)),
                      SizedBox(height: 31),
                      Text('${notifidetaillist[widget.items].detail}', style: regular12.copyWith(color: gray800)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('로딩 중', style: semiBold14.copyWith(color: gray800)),
                      SizedBox(height: 4),
                      Text('로딩 중', style: regular14.copyWith(color: gray500)),
                      SizedBox(height: 31),
                      Text('로딩 중', style: regular14.copyWith(color: gray800)),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
