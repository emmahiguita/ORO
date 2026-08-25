import 'package:get/get.dart';
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
import 'package:oro/binding/home_binding.dart';
import 'package:oro/binding/items_binding.dart';
import 'package:oro/binding/item_details_binding.dart';
import 'package:oro/view/screens/home/home.dart';
import 'package:oro/view/screens/items/itemdetails.dart';
import 'package:oro/view/screens/settings/settings.dart';

List<GetPage<dynamic>>? route = [
  GetPage(
    name: "/",
    page: () => const OroIntroVideoScreen(),
    middlewares: [MyMiddleware()],
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: Approutes.introVideo,
    page: () => const OroIntroVideoScreen(canDismiss: true),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: Approutes.onBoarding,
    page: () => const OnBoarding(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),

  //auth
  GetPage(
    name: Approutes.login,
    page: () => const Login(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.signUp,
    page: () => const SignUp(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.forgot,
    page: () => const ForgotPassword(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.verify,
    page: () => const VerifyCode(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.rest,
    page: () => const RestPassword(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.verifyCodeSignUp,
    page: () => const VerifyCodeSignUp(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),

  //home
  GetPage(
    name: Approutes.home,
    page: () => const Home(),
    binding: HomeBinding(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.homescreen,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.item,
    page: () => const ItemsView(),
    binding: ItemsBinding(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.itemDetails,
    page: () => const ItemDetails(),
    binding: ItemDetailsBinding(),
    transition: Transition.rightToLeftWithFade,
    transitionDuration: const Duration(milliseconds: 350),
  ),
  GetPage(
    name: Approutes.viewFavourite,
    page: () => const ViewFavourite(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),

  //setting
  GetPage(
    name: Approutes.settings,
    page: () => const Settings(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),

  //delivery
  GetPage(
    name: Approutes.deliveryRequests,
    page: () => const DeliveryRequests(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.deliveryHome,
    page: () => const DeliveryHome(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
  GetPage(
    name: Approutes.adminHome,
    page: () => const AdminHome(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 320),
  ),
];
