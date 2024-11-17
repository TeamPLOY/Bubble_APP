import 'package:bubble_app/presentation/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("백그라운드 메시지 처리: ${message.notification?.body}");
}

Future<void> initializeNotification() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  print('사용자 권한 상태: ${settings.authorizationStatus}');

  // Foreground 메시지 처리
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Foreground Message 수신: ${message.notification?.body}');
    }
  });

  // Background에서 알림 클릭시 처리
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Background Message 수신: ${message.notification?.body}');
  });

  // 종료된 상태에서 알림 클릭으로 앱 실행 시 처리
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('Terminated state Message: ${initialMessage.notification?.body}');
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");

    // Firebase 초기화를 먼저 수행
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 그 다음 알림 초기화
    await initializeNotification();

    runApp(const MyApp());
  } catch (e) {
    print("초기화 중 오류 발생: $e");
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingPage(),
    );
  }
}
