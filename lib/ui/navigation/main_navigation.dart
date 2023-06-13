import 'package:flutter/material.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/widgets/auth/register/check_otp/check_otp_model.dart';
import 'package:uide/ui/widgets/auth/register/create_account/create_account_model.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_screen.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_model.dart';
import 'package:uide/ui/widgets/main/admin/admin_model.dart';
import 'package:uide/ui/widgets/main/admin/admin_screen.dart';
import 'package:uide/ui/widgets/main/ads/create_ad_screen/create_ad_screen_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_screen.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_list/my_ads_list_model.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_list/my_ads_list_screen.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_list/my_ads_screen.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_model.dart';
import 'package:uide/ui/widgets/main/main_screen/main_screen_model.dart';
import 'package:uide/ui/widgets/main/profile/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:uide/ui/widgets/main/profile/profile_screen_widget.dart';
import 'package:uide/ui/widgets/main/profile/questions_about_screen/questions_about_screen.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_details/roommate_details_model.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_details/roommate_details_screen.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_screen.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_model.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_widget.dart';
import 'package:uide/utils/connectivity_check_widget.dart';

import 'package:uide/ui/widgets/auth/login/auth_model.dart';
import 'package:uide/ui/widgets/auth/login/auth_screen_widget.dart';
import 'package:uide/ui/widgets/main/main_screen/main_screen_widget.dart';
import 'package:uide/ui/widgets/main/ads/create_ad_screen/create_ad_screen_widget.dart';
import 'package:uide/ui/widgets/auth/register/create_account/create_account_screen.dart';
import 'package:uide/ui/widgets/auth/register/check_otp/check_otp_screen.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_list/roommate_list_model.dart';

abstract class MainNavigationRouteNames {
  static const authScreen = 'auth_screen';
  static const mainScreen = '/main_screen';
  static const createAccountScreen = '/create_account_screen';
  static const otpFormScreen = '/otp_form_screen';
  static const createPasswordScreen = 'create_password_screen';
  static const houseDetails = '/house_list/house_details';
  static const roommateList = '/roommate_list';
  static const roommateDetails = '/roommate_list/roommate_details';
  static const savedRoomsList = '/main_screen/saved_rooms_list';
  static const homeScreen = '/main_screen/homeScreen';
  static const profileScreen = '/main_screen/profileScreen';
  static const createAdScreen = '/create_ad_screen';
  static const myAdsScreen = '/my_ads_screen';
  static const myAdsDetails = '/my_ads_screen/my_ads_details';
  static const questionsAboutScreen = '/questions_about_screen';
  static const privacyPolicyScreen = '/privacy_policy_screen';
  static const adminScreen = '/admin_screen';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.authScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.authScreen: (context) => ProjectNotifierProvider(
          create: () => AuthModel(),
          child: const AuthScreenWidget(),
        ),
    MainNavigationRouteNames.createAccountScreen: (context) =>
        ProjectNotifierProvider(
          create: () => CreateAccountModel(),
          child: const CreateAccountScreen(),
        ),
    MainNavigationRouteNames.otpFormScreen: (context) =>
        ProjectNotifierProvider(
          create: () => CheckOtpModel(),
          child: const CheckOtpScreen(),
        ),
    MainNavigationRouteNames.createPasswordScreen: (context) =>
        ProjectNotifierProvider(
          create: () => CreatePasswordModel(),
          child: const CreatePasswordScreenWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => ConnectivityCheckWidget(
          connectedWidget: ProjectNotifierProvider(
              create: () => MainScreenModel(), child: const MainScreenWidget()),
        ),
    MainNavigationRouteNames.savedRoomsList: (context) =>
        ConnectivityCheckWidget(
          connectedWidget: ProjectNotifierProvider(
            create: () => SavedHouseListModel()..setupHouses(context),
            isManagingModel: false,
            child: const SavedHouseListWidget(),
          ),
        ),
    MainNavigationRouteNames.adminScreen: (context) => ConnectivityCheckWidget(
          connectedWidget: ProjectNotifierProvider(
            create: () => AdminModel()..setupHouses(context),
            isManagingModel: false,
            child: const AdminScreenWidget(),
          ),
        ),
    MainNavigationRouteNames.profileScreen: (context) =>
        const ConnectivityCheckWidget(
          connectedWidget: UserProfileScreen(),
        ),
    MainNavigationRouteNames.myAdsScreen: (context) => ProjectNotifierProvider(
          isManagingModel: false,
          create: () => MyAdsModel()..loadHouses(context),
          child: const MyAdsScreen(),
        ),
    MainNavigationRouteNames.createAdScreen: (context) =>
        ProjectNotifierProvider(
          create: () => CreateAdScreenModel(),
          child: const CreateAdScreenWidget(),
        ),
    MainNavigationRouteNames.questionsAboutScreen: (context) =>
        const QuestionsAboutScreen(),
    MainNavigationRouteNames.privacyPolicyScreen: (context) =>
        const PrivacyPolicyScreen(),
    MainNavigationRouteNames.houseDetails: (context) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      final houseId = arguments['id'];
      final pageIndex = arguments['pageIndex'];
      return ConnectivityCheckWidget(
        connectedWidget: ProjectNotifierProvider(
          isManagingModel: false,
          create: () => HouseDetailsModel(houseId)..loadDetails(context),
          child: HouseDetailsScreen(
            pageIndex: pageIndex,
            houseId: houseId,
          ),
        ),
      );
    },
    MainNavigationRouteNames.myAdsDetails: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      final houseId = arguments.toString();
      return ConnectivityCheckWidget(
        connectedWidget: ProjectNotifierProvider(
          isManagingModel: false,
          create: () => MyAdsDetailsModel(houseId),
          child: MyAdsDetailsScreen(
            houseId: houseId,
          ),
        ),
      );
    },
    MainNavigationRouteNames.roommateDetails: (context) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      final roommateId = arguments['id'];
      final pageIndex = arguments['pageIndex'];
      return ConnectivityCheckWidget(
        connectedWidget: ProjectNotifierProvider(
          isManagingModel: false,
          create: () => RoommateDetailsModel(roommateId)..loadDetails(context),
          child: RoommateDetailsScreen(
            pageIndex: pageIndex,
            roommateId: roommateId,
          ),
        ),
      );
    },
  };
}
