import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static String get delete_url => '$baseUrl/user';
  static String get cancel_post_url => '$baseUrl/reservation/cancel';
  static String get check_get_url => '$baseUrl/isReserved';
  static String get email_check_url => '$baseUrl/email/check';
  static String get email_get_url => '$baseUrl/email';
  static String get email_post_url => '$baseUrl/email';
  static String get join_reservation_url => '$baseUrl/reservation';
  static String get join_url => '$baseUrl/signup';
  static String get login_post_url => '$baseUrl/login';
  static String get logout_url => '$baseUrl/logout';
  static String get machine_get_url => '$baseUrl/washing';
  static String get maching_save_url => '$baseUrl/notification/save';
  static String get maching_check_url => '$baseUrl/notification/check';
  static String get notification_detail_url => '$baseUrl/notification/detail';
  static String get notification_notification_url => '$baseUrl/notification/notification';
  static String get notification_url => '$baseUrl/notification';
  static String get refresh_post_url => '$baseUrl/refresh-token';
  static String get reservation_get_url => '$baseUrl/reservation';
  static String get reservation_post_url => '$baseUrl/reservation';
  static String get reseration_state_url => '$baseUrl/notification/history';
  static String get user_get_url => '$baseUrl/user';
}
