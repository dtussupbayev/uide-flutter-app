import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/home/home_screen_widget.dart';
import 'package:uide/ui/widgets/main/main_screen/main_screen_model.dart';
import 'package:uide/ui/widgets/main/profile/profile_screen_model.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_model.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_widget.dart';
import 'package:uide/ui/widgets/main/profile/profile_screen_widget.dart';
import 'package:uide/utils/connectivity_check_widget.dart';

class MainScreenWidget extends StatefulWidget {
  final int selectedPageIndex;

  const MainScreenWidget({Key? key, this.selectedPageIndex = 1})
      : super(key: key);

  @override
  State<MainScreenWidget> createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<MainScreenWidget>
    with AutomaticKeepAliveClientMixin {
  final savedHouseListModel = SavedHouseListModel();

  int _selectedPageIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.selectedPageIndex;
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void changePage(int selectedPageIndex) {
    setState(() {
      _selectedPageIndex = selectedPageIndex;
      _pageController?.jumpToPage(selectedPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<MainScreenModel>(context);

    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      extendBody: true,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ConnectivityCheckWidget(
              connectedWidget: ProjectNotifierProvider(
                create: () => SavedHouseListModel()..setupHouses(context),
                isManagingModel: false,
                child: const SavedHouseListWidget(),
              ),
            ),
            HomeScreenWidget(
              isFilterMenuOpen: model!.isFilterMenuOpen,
              toggleFilterMenu: model.toggleFilterMenu,
            ),
            ConnectivityCheckWidget(
              connectedWidget: ProjectNotifierProvider(
                  create: () => UserProfileModel()..loadProfile(context),
                  isManagingModel: false,
                  child: const UserProfileScreen()),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Visibility(
        visible: !model.isFilterMenuOpen,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: kIsWeb ||
                      Platform.isMacOS ||
                      Platform.isLinux ||
                      Platform.isWindows
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width * 0.5,
              decoration: kBottomNavigationBarDecoration,
              child: CustomBottomNavigationBar(
                selectedPageIndex: _selectedPageIndex,
                onTapItem: changePage,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedPageIndex;
  final Function(int) onTapItem;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedPageIndex,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      unselectedFontSize: 20,
      selectedFontSize: 0,
      selectedItemColor: ProjectColors.kWhite,
      unselectedItemColor: ProjectColors.kWhite,
      currentIndex: selectedPageIndex,
      onTap: (selectedPageIndex) => onTapItem(selectedPageIndex),
      backgroundColor: ProjectColors.kTransparent,
      elevation: 0.0,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_outline_outlined,
            size: 26,
          ),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 62.0,
            height: 62.0,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: kMainBottomNavigationIconGradient,
              ),
              child: Center(
                child: Icon(
                  Icons.home_outlined,
                  color: ProjectColors.kWhite,
                  size: 34.0,
                ),
              ),
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_rounded,
            size: 26,
          ),
          label: 'Профиль',
        ),
      ],
    );
  }
}
