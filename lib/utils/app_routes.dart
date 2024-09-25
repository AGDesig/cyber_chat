
import 'package:get/get.dart';
import 'package:social_app/Controllers/profile_controller.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/Controllers/splash_screen_controller.dart';
import 'package:social_app/View/chat_view.dart';
import 'package:social_app/View/editing_profile_screen_view.dart';
import 'package:social_app/View/friend_request_view.dart';
import 'package:social_app/View/home_screen_view.dart';
import 'package:social_app/View/notification_screen_view.dart';
import 'package:social_app/View/post_screen_view.dart';
import 'package:social_app/View/profile_view.dart';
import 'package:social_app/View/signin_view.dart';
import 'package:social_app/View/splash_screen_view.dart';
import 'package:social_app/Controllers/chat_controller.dart';
import 'package:social_app/res/widget_controller/navigation_bar_controller.dart';
import 'app_routes.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String friendRequests = '/friend-requests';
  static const String chat = '/chat/:chatId';
  static const String profile = '/profile';
  static const String editProfile = '/editProfileScreen';
  static const String post = '/post';
  static const String notification = '/notification';
}



class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreenView(),
      binding:  BindingsBuilder(() {
        Get.put(SplashScreenView());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => SignInPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [
        BindingsBuilder(() {
          Get.put(NavigationBarController(),tag: "overall");
          Get.put(ChatController());
          Get.put(SignInController());
        },),
      ],
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () {
        // Fetch arguments using Get.arguments
        final Map<String, dynamic> args = Get.arguments;
        final String chatId = args['chatId'];
        final String currentUserUid = args['currentUserUid'];
        final String otherUserUid = args['otherUserUid'];

        return ChatScreen(
          chatId: chatId,
          currentUserUid: currentUserUid,
          otherUserUid: otherUserUid,
        );
      },
      binding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),

    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => PostScreen(),

    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),

    ),
    GetPage(
      name: AppRoutes.friendRequests,
      page: () => FriendRequestScreen(),

    ),GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),

    ),


  ];
}
