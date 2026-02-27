// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// import 'config.dart';
// import 'modules/models/notificationModel.dart';
// import 'routes/app_pages.dart';
//
// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('ic_launcher');
//
// /// Note: permissions aren't requested here just to demonstrate that can be
// /// done later
// final DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//   requestAlertPermission: false,
//   requestBadgePermission: false,
//   requestSoundPermission: false,
// );
//
// final InitializationSettings initializationSettings = InitializationSettings(
//   android: initializationSettingsAndroid,
//   iOS: initializationSettingsIOS,
// );
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseConfig.platformOptions,
//   );
// }
//
// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
// @pragma('vm:entry-point')
// void notificationTapBackground(
//     NotificationResponse notificationResponse) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseConfig.platformOptions,
//   );
//   onTapBackground(notificationResponse);
//   // handle action
// }
//
// Future<dynamic> onTapBackground(notificationResponse) async {
//   print("Heavy Background Tapped");
//   if (notificationResponse != null) {
//     if (notificationResponse.payload!.isNotEmpty) {
//       // CurrentContractDetail? currentContractDetail;
//       NotificationModel model = NotificationModel.fromJson(
//           json.decode(notificationResponse.payload!));
//
//       ///=================Route Notification================///
//       switch (model.relatedType) {
//         case 'message':
//           Get.toNamed(Routes.chatScreenNew, arguments: {
//             "id": model.sender,
//             "channelId": model.relatedId,
//           });
//           break;
//         case 'post':
//           Get.toNamed(Routes.displayPostScreen, arguments: {
//             "postId": model.relatedId,
//           });
//           break;
//         case 'vote-up':
//           Get.toNamed(Routes.displayPostScreen, arguments: {
//             "postId": model.relatedId,
//           });
//           break;
//         case 'vote-down':
//           Get.toNamed(Routes.displayPostScreen, arguments: {
//             "postId": model.relatedId,
//           });
//           break;
//         case 'vote-removed':
//           Get.toNamed(Routes.displayPostScreen, arguments: {
//             "postId": model.relatedId,
//           });
//           break;
//
//         ///-------competition------///
//         case 'competition-joined':
//           Get.toNamed(Routes.competitionWall, arguments: [
//             (model.relatedId),
//           ]);
//           break;
//
//         case 'competition-started':
//           Get.toNamed(Routes.competitionWall, arguments: [
//             (model.relatedId),
//           ]);
//           break;
//
//         case 'competition-completed':
//           Get.offNamed(Routes.competitionWinner,
//               arguments: [(model.relatedId), "", "fromHome"]);
//           break;
//
//         case 'competition-winner':
//           Get.offNamed(Routes.competitionWinner,
//               arguments: [(model.relatedId), "", "fromHome"]);
//           break;
//
//         ///-------follow - Unfollow------///
//         case 'new-follower':
//           Get.toNamed(Routes.otherUserProfile,
//               arguments: [(model.relatedId), "fromOther"]);
//           break;
//         case 'un-follow':
//           Get.toNamed(Routes.otherUserProfile,
//               arguments: [(model.relatedId), "fromOther"]);
//           break;
//       }
//     }
//   }
// }
//
// Future<dynamic> onSelectNotification(
//     NotificationResponse notificationResponse) async {
//   if (notificationResponse.payload!.isNotEmpty) {
//     // CurrentContractDetail? currentContractDetail;
//
//     NotificationModel model =
//         NotificationModel.fromJson(json.decode(notificationResponse.payload!));
//
//     ///=================Route Notification================///
//     switch (model.relatedType) {
//       case 'message':
//         Get.toNamed(Routes.chatScreenNew, arguments: {
//           "id": model.sender,
//           "channelId": model.relatedId,
//         });
//         break;
//       case 'post':
//         Get.toNamed(Routes.displayPostScreen, arguments: {
//           "postId": model.relatedId,
//         });
//         break;
//       case 'vote-up':
//         Get.toNamed(Routes.displayPostScreen, arguments: {
//           "postId": model.relatedId,
//         });
//         break;
//       case 'vote-down':
//         Get.toNamed(Routes.displayPostScreen, arguments: {
//           "postId": model.relatedId,
//         });
//         break;
//       case 'vote-removed':
//         Get.toNamed(Routes.displayPostScreen, arguments: {
//           "postId": model.relatedId,
//         });
//         break;
//
//       ///-------competition------///
//       case 'competition-joined':
//         Get.toNamed(Routes.competitionWall, arguments: [
//           (model.relatedId),
//         ]);
//         break;
//
//       case 'competition-started':
//         Get.toNamed(Routes.competitionWall, arguments: [
//           (model.relatedId),
//         ]);
//         break;
//
//       case 'competition-completed':
//         Get.offNamed(Routes.competitionWinner,
//             arguments: [(model.relatedId), "", "fromHome"]);
//         break;
//
//       case 'competition-winner':
//         Get.offNamed(Routes.competitionWinner,
//             arguments: [(model.relatedId), "", "fromHome"]);
//         break;
//
//       ///-------follow - Unfollow------///
//       case 'new-follower':
//         Get.toNamed(Routes.otherUserProfile,
//             arguments: [(model.relatedId), "fromOther"]);
//         break;
//       case 'un-follow':
//         Get.toNamed(Routes.otherUserProfile,
//             arguments: [(model.relatedId), "fromOther"]);
//         break;
//     }
//   }
// }
