import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/resources/resources.dart';

import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/profile/img.dart';
import 'package:uide/ui/widgets/main/profile/profile_screen_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  static const List<MenuRowData> firstMenuRow = [
    MenuRowData(Icons.settings_outlined, 'Настройки'),
  ];

  static const List<MenuRowData> secondMenuRow = [
    MenuRowData(Icons.call, '7 747 047 0363'),
  ];
  static const List<MenuRowData> thirdMenuRow = [
    MenuRowData(Icons.shield, 'Политика конфиденциальности'),
  ];

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileModel model = UserProfileModel();

  @override
  void initState() {
    super.initState();

    model.loadProfile(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    model.loadProfile(context);
  }

  Future<void> _launchCall() async {
    String phoneNumber = 'tel:+77470470363';
    final phoneNumberUri = Uri.parse(phoneNumber);

    if (await canLaunchUrl(phoneNumberUri)) {
      await launchUrl(phoneNumberUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> _launchEmailApp() async {
    const email = 'support@uide.com';
    const subject = 'Uide';
    const body = '';

    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<UserProfileModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    return DecoratedBox(
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 66,
              centerTitle: true,
              elevation: 0,
              title: const Center(child: Text('Профиль')),
              backgroundColor: ProjectColors.kTransparent,
            ),
            backgroundColor: ProjectColors.kTransparent,
            body: model.userProfileResponse != null
                ? ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      _UserInfo(model: model),
                      const SizedBox(height: 20),
                      const MyAdsRowItemWidget(),
                      const CreateAdRowItemWidget(),
                      const SavedRoomsRowItemWidget(),
                      const SignOutRowItemWidget(),
                      model.isAdmin == true
                          ? const AdminRowItemWidget()
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        child: Text(
                          'Помощь',
                          style: TextStyle(
                            fontSize: 16,
                            color: ProjectColors.kDarkGreen,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _launchCall,
                        child: const _MenuWidgetRow(
                          menuRowData: MenuRowData(Icons.call, '+77470470363'),
                        ),
                      ),
                      InkWell(
                        onTap: _launchEmailApp,
                        child: const _MenuWidgetRow(
                          menuRowData:
                              MenuRowData(Icons.email, 'support@uide.com'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const QuestionsAboutRowItemWidget(),
                      const PrivacyPolicyRowItemWidget(),
                      const SizedBox(height: 80)
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserProfileModel model;
  const _UserInfo({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.kTransparent,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _AvatarWidget(
              model: model,
            ),
            const SizedBox(height: 30),
            _UserNameWidget(model: model),
            const SizedBox(height: 10),
            _UserPhoneWidget(model: model),
            const SizedBox(height: 10),
            // const _UserNickWidget(),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyRowItemWidget extends StatelessWidget {
  const PrivacyPolicyRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.privacyPolicyScreen,
      ),
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(Icons.shield, 'Политика конфиденциальности'),
      ),
    );
  }
}

class QuestionsAboutRowItemWidget extends StatelessWidget {
  const QuestionsAboutRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.questionsAboutScreen,
      ),
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(Icons.question_answer, 'Вопросы про Uide'),
      ),
    );
  }
}

class MyAdsRowItemWidget extends StatelessWidget {
  const MyAdsRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(
          Icons.view_list_outlined,
          'Мои обьявления',
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.myAdsScreen,
      ),
    );
  }
}

class CreateAdRowItemWidget extends StatelessWidget {
  const CreateAdRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(
          Icons.create_rounded,
          'Создать обьявление',
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.createAdScreen,
      ),
    );
  }
}

class SavedRoomsRowItemWidget extends StatelessWidget {
  const SavedRoomsRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(
          Icons.bookmark_border,
          'Избранное',
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.savedRoomsList,
      ),
    );
  }
}

class AdminRowItemWidget extends StatelessWidget {
  const AdminRowItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(
          Icons.admin_panel_settings,
          'Админ-панель',
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        MainNavigationRouteNames.adminScreen,
      ),
    );
  }
}

class SignOutRowItemWidget extends StatelessWidget {
  const SignOutRowItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Get.defaultDialog(
          title: '',
          content: const Text(
            'Выйти из аккаунта?',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: ProjectColors.kWhite,
              fontSize: 20,
            ),
          ),
          titlePadding: const EdgeInsets.all(0),
          textConfirm: 'Выйти',
          textCancel: 'Отменить',
          cancelTextColor: ProjectColors.kDarkerDarkGreen,
          confirmTextColor: ProjectColors.kWhite,
          buttonColor: ProjectColors.kTransparent,
          backgroundColor: ProjectColors.kDialogBackgroundColor,
          radius: 20,
          onConfirm: () {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
            TokenDataProvider().setToken(null);
            TokenDataProvider().setEmail(null);
            TokenDataProvider().setPassword(null);

            Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigationRouteNames.authScreen,
              (route) => false,
            );
          },
        );
      },
      child: const _MenuWidgetRow(
        menuRowData: MenuRowData(Icons.logout_outlined, 'Выход'),
      ),
    );
  }
}

class MenuRowWidget extends StatelessWidget {
  final MenuRowData menuRowData;

  const MenuRowWidget({
    super.key,
    required this.menuRowData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            menuRowData.icon,
            color: ProjectColors.kWhite,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              menuRowData.text,
              style: const TextStyle(color: ProjectColors.kWhite),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: ProjectColors.kWhite,
          ),
        ],
      ),
    );
  }
}

class MenuRowData {
  final IconData icon;
  final String text;

  const MenuRowData(this.icon, this.text);
}

class _MenuWidgetRow extends StatelessWidget {
  final MenuRowData menuRowData;

  const _MenuWidgetRow({
    required this.menuRowData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            menuRowData.icon,
            color: ProjectColors.kWhite,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              menuRowData.text,
              style: const TextStyle(color: ProjectColors.kWhite),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: ProjectColors.kWhite,
          ),
        ],
      ),
    );
  }
}

class _UserNickWidget extends StatefulWidget {
  const _UserNickWidget();

  @override
  State<_UserNickWidget> createState() => _UserNickWidgetState();
}

class _UserNickWidgetState extends State<_UserNickWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      '@d.tusupbaev',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
    );
  }
}

class _UserPhoneWidget extends StatelessWidget {
  final UserProfileModel model;

  const _UserPhoneWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Text(
      model.userProfileResponse!.phoneNumber ?? '',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
    );
  }
}

class _UserNameWidget extends StatelessWidget {
  final UserProfileModel? model;
  const _UserNameWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Text(
      model!.userProfileResponse!.email ?? '',
      style: const TextStyle(
        color: ProjectColors.kWhite,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  final UserProfileModel? model;
  const _AvatarWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 150,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          LongPressZoomImage(
            isNetworkImage: true,
            imageUrl: Images.avatarPlaceholder,
            height: 150,
            width: 150,
            model: model,
            onRetryPressed: model!.reloadConnectivityWidget,
          ),
          Positioned(
            top: 10,
            right: 0,
            child: TextButton(
              onPressed: () {
                model!.createImageUrl;
              },
              child: const Text(
                'Изм.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
