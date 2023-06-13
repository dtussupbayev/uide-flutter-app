import 'package:flutter/material.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/house/house_list/house_list_model.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_list/roommate_list_model.dart';
import 'package:uide/ui/widgets/main/house/house_list/house_list_widget.dart';
import 'package:uide/utils/connectivity_check_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  final bool? isFilterMenuOpen;
  final VoidCallback toggleFilterMenu;

  const HomeScreenWidget({
    Key? key,
    this.isFilterMenuOpen,
    required this.toggleFilterMenu,
  }) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => HomeScreenWidgetState();
}

class HomeScreenWidgetState extends State<HomeScreenWidget>
    with SingleTickerProviderStateMixin {
  final houseListModel = HouseListModel();
  late TabController _tabController;
  GlobalKey<ConnectivityCheckWidgetState> connectivityWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    houseListModel.setupHouses(context);
  }

  @override
  void didChangeDependencies() {
    houseListModel.setupHouses(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void reloadConnectivityWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivityWidgetKey.currentState?.retryConnectivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.kMediumGreen,
        toolbarHeight: 0,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(47.5),
          child: TabBar(
            physics: const BouncingScrollPhysics(),
            automaticIndicatorColorAdjustment: false,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
            ),
            isScrollable: false,
            indicatorWeight: 0.5,
            indicatorColor: ProjectColors.kWhite,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Дома'),
              Tab(text: 'Соседи'),
            ],
          ),
        ),
      ),
      body: ConnectivityCheckWidget(
          key: connectivityWidgetKey,
          connectedWidget: TabBarView(
            controller: _tabController,
            children: [
              ProjectNotifierProvider(
                create: () => houseListModel..setupHouses(context),
                isManagingModel: false,
                child: HouseListWidget(
                  toggleFilterMenu: widget.toggleFilterMenu,
                  isFilterMenuOpen: null,
                  onRetryPressed:
                      reloadConnectivityWidget, // Pass the callback function
                ),
              ),
              ProjectNotifierProvider(
                create: () => houseListModel..setupHouses(context),
                isManagingModel: false,
                child: HouseListWidget(
                  toggleFilterMenu: widget.toggleFilterMenu,
                  isFilterMenuOpen: null,
                  onRetryPressed:
                      reloadConnectivityWidget, // Pass the callback function
                ),
              ),
            ],
          )),
    );
  }
}
