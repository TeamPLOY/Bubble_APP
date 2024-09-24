import 'package:bubble_app/Components/Box/bubblebox.dart';
import 'package:bubble_app/Components/Footer/footer.dart';
import 'package:bubble_app/Components/Header/main_header.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(hasAlarm: true),
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height - 104,
                child: Column(
                  children: [
                    Bubblebox(
                      place: 1,
                      hour: 01,
                      minute: 23,
                      device: "세탁가",
                    ),
                  ],
                ),
              ),
              Footer()
            ],
          )),
    );
  }
}
