import 'package:flutter/material.dart';
import 'package:uide/provider/provider.dart';
import 'package:uide/ui/widgets/auth/register/check_otp/check_otp_model.dart';
import 'package:uide/ui/widgets/auth/register/create_account/create_account_model.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_screen.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_model.dart';
import 'package:uide/ui/widgets/main/ads/create_ad_screen/create_ad_screen_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_screen.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_list/my_ads_list_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_list/my_ads_list_screen.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_model.dart';
import 'package:uide/ui/widgets/main/profile/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:uide/ui/widgets/main/profile/questions_about_screen/questions_about_screen.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_details/roommate_details_screen.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_screen.dart';
import 'package:uide/ui/widgets/main/house/house_list/house_list_widget.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_model.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_widget.dart';

import '../ui/widgets/auth/login/auth_model.dart';
import '../ui/widgets/auth/login/auth_screen_widget.dart';
import '../ui/widgets/main/main_screen_widget.dart';
import '../ui/widgets/main/ads/create_ad_screen/create_ad_screen_widget.dart';
import '../ui/widgets/auth/register/create_account/create_account_screen.dart';
import '../ui/widgets/auth/register/check_otp/check_otp_screen.dart';
import '../ui/widgets/main/rommate/roommate_list/roommate_list.dart';

abstract class MainNavigationRouteNames {
  static const authScreen = 'auth_screen';
  static const mainScreen = '/main_screen';
  static const createAccountScreen = '/create_account_screen';
  static const otpFormScreen = '/otp_form_screen';
  static const createPasswordScreen = 'create_password_screen';
  static const houseList = '/house_list';
  static const houseDetails = '/house_list/house_details';
  static const roommateList = '/roommate_list';
  static const roommateDetails = '/roommate_list/roommate_details';
  static const savedRoomsList = '/main_screen/saved_rooms_list';
  static const createAdScreen = '/create_ad_screen';
  static const myAdsScreen = '/my_ads_screen';
  static const myAdsDetails = '/my_ads_screen/my_ads_details';
  static const questionsAboutScreen = '/questions_about_screen';
  static const privacyPolicyScreen = '/privacy_policy_screen';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.authScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.authScreen: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthScreenWidget(),
        ),
    MainNavigationRouteNames.createAccountScreen: (context) => NotifierProvider(
          create: () => CreateAccountModel(),
          child: const CreateAccountScreen(),
        ),
    MainNavigationRouteNames.otpFormScreen: (context) => NotifierProvider(
          create: () => CheckOtpModel(),
          child: const CheckOtpScreen(),
        ),
    MainNavigationRouteNames.createPasswordScreen: (context) =>
        NotifierProvider(
          create: () => CreatePasswordModel(),
          child: const CreatePasswordScreenWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
    MainNavigationRouteNames.houseList: (context) => const HouseListWidget(),
    MainNavigationRouteNames.roommateList: (context) =>
        const RoommateListWidget(),
    MainNavigationRouteNames.savedRoomsList: (context) => NotifierProvider(
          create: () => SavedHouseListModel()..setupHouses(context),
          isManagingModel: false,
          child: const SavedHouseListWidget(),
        ),
    MainNavigationRouteNames.myAdsScreen: (context) => NotifierProvider(
          isManagingModel: false,
          create: () => MyAdsModel()..loadHouses(context),
          child: const MyAdsScreenWidget(),
        ),
    MainNavigationRouteNames.createAdScreen: (context) => NotifierProvider(
          create: () => CreateAdScreenModel(),
          child: const CreateAdScreenWidget(),
        ),
    MainNavigationRouteNames.questionsAboutScreen: (context) =>
        const QuestionsAboutScreen(),
    MainNavigationRouteNames.privacyPolicyScreen: (context) =>
        const PrivacyPolicyScreen(),
    MainNavigationRouteNames.houseDetails: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      final houseId = arguments.toString();
      return NotifierProvider(
        isManagingModel: false,
        create: () => HouseDetailsModel(houseId),
        child: HouseDetailsScreen(
          houseId: houseId,
        ),
      );
    },

    MainNavigationRouteNames.myAdsDetails: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      final houseId = arguments.toString();
      return NotifierProvider(
        isManagingModel: false,
        create: () => MyAdsDetailsModel(houseId),
        child: MyAdsDetailsScreen(
          houseId: houseId,
        ),
      );
    },

    // ignore: equal_keys_in_map
    MainNavigationRouteNames.roommateDetails: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is int) {
        return RoommateDetailsScreen(
          roommateId: arguments,
        );
      } else {
        return const RoommateDetailsScreen(roommateId: 0);
      }
    },
  };
}
