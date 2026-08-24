import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/middleware/myMiddleware.dart';
import 'package:oro/view/screens/OnBoarding.dart';
import 'package:oro/view/screens/intro/oro_intro_video_screen.dart';
import 'package:oro/view/screens/admin/adminhome.dart';
import 'package:oro/view/screens/delivery/deliveryhome.dart';
import 'package:oro/view/screens/delivery/deliveryrequests.dart';
import 'package:oro/view/screens/home/homescreen.dart';
import 'package:oro/view/screens/items/ItemsView.dart';
import 'package:oro/view/screens/items/viewFavourite.dart';
import 'package:oro/view/screens/resetpassword/resetpassword.dart';
import 'package:oro/view/screens/resetpassword/forgotpassword.dart';
import 'package:oro/view/screens/auth/login.dart';
import 'package:oro/view/screens/auth/signUp.dart';
import 'package:oro/view/screens/resetpassword/verifycode.dart';
import 'package:oro/view/screens/auth/verifycodesignup.dart';
import 'package:oro/view/screens/home/home.dart';
import 'package:oro/view/screens/items/itemdetails.dart';
import 'package:oro/view/screens/settings/settings.dart';

List<GetPage<dynamic>>? route = [
  GetPage(
      name: "/",
      page: () => const OroIntroVideoScreen(),
      middlewares: [MyMiddleware()]),
  GetPage(name: Approutes.introVideo, page: () => const OroIntroVideoScreen(canDismiss: true)),
  GetPage(name: Approutes.onBoarding, page: () => const OnBoarding()),

  //auth
  GetPage(name: Approutes.login, page: () => const Login()),
  GetPage(name: Approutes.signUp, page: () => const SignUp()),
  GetPage(name: Approutes.forgot, page: () => const ForgotPassword()),
  GetPage(name: Approutes.verify, page: () => const VerifyCode()),
  GetPage(name: Approutes.rest, page: () => const RestPassword()),
  GetPage(
      name: Approutes.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),
  //home
  GetPage(name: Approutes.home, page: () => const Home()),
  GetPage(name: Approutes.homescreen, page: () => const HomeScreen()),
  GetPage(name: Approutes.item, page: () => const ItemsView()),
  GetPage(name: Approutes.itemDetails, page: () => const ItemDetails()),
  GetPage(name: Approutes.viewFavourite, page: () => const ViewFavourite()),
  //setting
  GetPage(name: Approutes.settings, page: () => const Settings()),
  //delivery
  GetPage(
      name: Approutes.deliveryRequests, page: () => const DeliveryRequests()),
  GetPage(name: Approutes.deliveryHome, page: () => const DeliveryHome()),
  GetPage(name: Approutes.adminHome, page: () => const AdminHome())
];
