import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uide/domain/data_provider/token_data_provider.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/resources/resources.dart';

import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/profile/img.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileWidget extends StatelessWidget {
  static const List<MenuRowData> firstMenuRow = [
    MenuRowData(Icons.settings_outlined, 'Настройки'),
  ];

  static const List<MenuRowData> secondMenuRow = [
    MenuRowData(Icons.call, '7 747 047 0363'),
  ];
  static const List<MenuRowData> thirdMenuRow = [
    MenuRowData(Icons.shield, 'Политика конфиденциальности'),
  ];

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

  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const _UserInfo(),
              const SizedBox(height: 20),
              const MyAdsRowItemWidget(),
              const CreateAdRowItemWidget(),
              const SavedRoomsRowItemWidget(),
              const SignOutRowItemWidget(),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                  menuRowData: MenuRowData(Icons.email, 'support@uide.com'),
                ),
              ),
              const SizedBox(height: 20),
              const QuestionsAboutRowItemWidget(),
              const PrivacyPolicyRowItemWidget(),
              const SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.kTransparent,
      width: double.infinity,
      child: const Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            _AvatarWidget(),
            SizedBox(height: 30),
            _UserNameWidget(),
            SizedBox(height: 10),
            _UserPhoneWidget(),
            SizedBox(height: 10),
            _UserNickWidget(),
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
  const _UserPhoneWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '+7(747)047 03 63',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
    );
  }
}

class _UserNameWidget extends StatelessWidget {
  const _UserNameWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Даулет Тусупбаев',
      style: TextStyle(
        color: ProjectColors.kWhite,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return const LongPressZoomImage(
      imageUrl: Images.userAvatar,
      height: 200,
      width: 200,
    );
  }
}
