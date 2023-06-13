import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/admin/admin_model.dart';
import 'package:transparent_image/transparent_image.dart';

class AdminScreenWidget extends StatefulWidget {
  const AdminScreenWidget({
    super.key,
  });

  @override
  State<AdminScreenWidget> createState() => _AdminScreenWidgetState();
}

class _AdminScreenWidgetState extends State<AdminScreenWidget> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return _DesktopLayout(widget: widget);
    }
    return _MobileLayout(widget: widget);
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.widget,
  });

  final AdminScreenWidget widget;

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<AdminModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    var windowWidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        gradient: kMainBackgroundGradientDecoration.gradient,
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          appBar: const SavedAppBar(),
          extendBody: true,
          backgroundColor: ProjectColors.kTransparent,
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  model.isContentEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.view_list_rounded,
                                  color: ProjectColors.kWhite,
                                  size: 32,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Нет новых обьявлении для проверки',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ProjectColors.kWhite,
                                  ),
                                ),
                                SizedBox(height: 7),
                              ],
                            ),
                          ),
                        )
                      : model.houses.isEmpty
                          ? const DesktopLayoutShimmerHousesListViewWidget()
                          : Stack(
                              children: [
                                DesktopLayoutHousesListViewWidget(
                                  model: model,
                                  onRetryPressed:
                                      model.reloadConnectivityWidget,
                                ),
                              ],
                            ),
                ],
              )),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.widget,
  });

  final AdminScreenWidget widget;

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<AdminModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        gradient: kMainBackgroundGradientDecoration.gradient,
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          appBar: const SavedAppBar(),
          extendBody: true,
          backgroundColor: ProjectColors.kTransparent,
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  model.isContentEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.view_list_rounded,
                                  color: ProjectColors.kWhite,
                                  size: 32,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Нет новых обьявлении для проверки',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ProjectColors.kWhite,
                                  ),
                                ),
                                SizedBox(height: 7),
                              ],
                            ),
                          ),
                        )
                      : model.houses.isEmpty
                          ? const ShimmerHousesListViewWidget()
                          : HousesListViewWidget(
                              model: model,
                              onRetryPressed: model.reloadConnectivityWidget,
                            ),
                ],
              )),
        ),
      ),
    );
  }
}

class HousesListViewWidget extends StatelessWidget {
  final Function onRetryPressed;

  const HousesListViewWidget({
    super.key,
    required this.model,
    required this.onRetryPressed,
  });

  final AdminModel? model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: model!.houses.length,
      itemBuilder: (context, index) {
        final house = model!.houses[index];
        return Column(
          children: [
            SizedBox(
              height: 400,
              child: HouseItem(
                house: house,
                onTap: () => model!.onHouseTap(context, index),
                onRetryPressed: onRetryPressed,
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class DesktopLayoutHousesListViewWidget extends StatelessWidget {
  final Function onRetryPressed;

  const DesktopLayoutHousesListViewWidget({
    super.key,
    required this.model,
    required this.onRetryPressed,
  });

  final AdminModel? model;

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;

    int determineCrossAxisCount() {
      if (windowWidth > 1000) {
        return 3;
      } else if (windowWidth > 502) {
        return 2;
      } else {
        return 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: determineCrossAxisCount(),
            childAspectRatio: 1,
            crossAxisSpacing: windowWidth > 800 ? 30 : 10,
            mainAxisSpacing: 30),
        padding: const EdgeInsets.only(bottom: 50),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: model!.houses.length,
        itemBuilder: (context, index) {
          final house = model!.houses[index];
          return SizedBox(
            height: MediaQuery.of(context).size.width * 0.3,
            child: DesktopLayoutHouseItem(
              house: house,
              onTap: () => model!.onHouseTap(context, index),
              onRetryPressed: onRetryPressed,
            ),
          );
        },
      ),
    );
  }
}

class ShimmerHousesListViewWidget extends StatelessWidget {
  const ShimmerHousesListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: ProjectColors.kBlack.withOpacity(0.3),
            highlightColor: ProjectColors.kBlack.withOpacity(0.1),
            child: SizedBox(
              width: 350,
              height: 350,
              child: Padding(
                padding: kHouseItemPadding,
                child: Container(
                  decoration: kShimmerHouseListViewDecoration,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 2);
  }
}

class DesktopLayoutShimmerHousesListViewWidget extends StatelessWidget {
  const DesktopLayoutShimmerHousesListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: ProjectColors.kBlack.withOpacity(0.3),
          highlightColor: ProjectColors.kBlack.withOpacity(0.1),
          child: Padding(
            padding: kHouseItemPadding,
            child: Container(
              decoration: kShimmerHouseListViewDecoration,
              clipBehavior: Clip.hardEdge,
            ),
          ),
        );
      },
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.4,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}

class HouseItem extends StatelessWidget {
  final HouseEntity house;
  final VoidCallback onTap;
  final Function onRetryPressed;

  const HouseItem({
    Key? key,
    required this.house,
    required this.onTap,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<AdminModel>(context);

    return Padding(
      padding: kHouseItemPadding,
      child: Material(
        color: ProjectColors.kTransparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                decoration: kHouseItemBoxDecoration,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const ShimmerImageWidget(),
                        FadeImageWidget(
                          model: model,
                          house: house,
                          onRetryPressed: onRetryPressed,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            HouseDescriptionWidget(house: house),
                            const SizedBox(height: 5),
                            HouseAddressDescriptionWidget(house: house),
                            const SizedBox(height: 30),
                            HousePriceWidget(house: house),
                            SizedBox(
                              width: double.infinity,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: ProjectColors.kMediumGreen,
                                  border: Border.all(
                                    color:
                                        ProjectColors.kBlack.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ProjectColors.kBlack.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    side: const BorderSide(
                                      width: 0,
                                      color: ProjectColors.kTransparent,
                                    ),
                                    foregroundColor: ProjectColors.kWhite,
                                    backgroundColor: ProjectColors.kTransparent,
                                  ),
                                  onPressed: () {
                                    model!.approveAd(house.id, context);
                                  },
                                  child: 2 > 1
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            color: ProjectColors.kWhite,
                                          ),
                                        )
                                      : const Text(
                                          'Одобрить обьявление',
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 22,
                bottom: 22,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ProjectColors.kTransparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 2.5),
                    child:
                        SizedBox.shrink(), // TODO model.approveHouseAd button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopLayoutHouseItem extends StatelessWidget {
  final HouseEntity house;
  final VoidCallback onTap;
  final Function onRetryPressed;

  const DesktopLayoutHouseItem({
    Key? key,
    required this.house,
    required this.onTap,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<AdminModel>(context);

    final windowWidth = MediaQuery.of(context).size.width;

    return Material(
      color: ProjectColors.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: kHouseItemBoxDecoration,
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const ShimmerImageWidget(),
                      FadeImageWidget(
                        model: model,
                        house: house,
                        onRetryPressed: onRetryPressed,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: windowWidth > 700 || windowWidth < 502
                              ? 30.0
                              : 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HouseDescriptionWidget(house: house),
                              const SizedBox(height: 10),
                              HouseAddressDescriptionWidget(house: house),
                            ],
                          ),
                          HousePriceWidget(house: house),
                          SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: ProjectColors.kMediumGreen,
                                border: Border.all(
                                  color: ProjectColors.kBlack.withOpacity(0.1),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        ProjectColors.kBlack.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  side: const BorderSide(
                                    width: 0,
                                    color: ProjectColors.kTransparent,
                                  ),
                                  foregroundColor: ProjectColors.kWhite,
                                  backgroundColor: ProjectColors.kTransparent,
                                ),
                                onPressed: () {
                                  model.approveAd(house.id, context);
                                },
                                child: model!.isApprovingInProgres
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: ProjectColors.kWhite,
                                        ),
                                      )
                                    : const Text(
                                        'Одобрить обьявление',
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 22,
              bottom: 22,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ProjectColors.kTransparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 2.5),
                  child: SizedBox.shrink(), // TODO model.approveHouseAd button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HousePriceWidget extends StatelessWidget {
  const HousePriceWidget({
    super.key,
    required this.house,
  });

  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Цена',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${house.price} тг/месяц',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            color: ProjectColors.kWhite,
          ),
        ),
      ],
    );
  }
}

class HouseAddressDescriptionWidget extends StatelessWidget {
  const HouseAddressDescriptionWidget({
    super.key,
    required this.house,
  });

  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    return Text(
      house.description,
      style: const TextStyle(
        color: ProjectColors.kWhite,
        fontSize: 12,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class HouseDescriptionWidget extends StatelessWidget {
  const HouseDescriptionWidget({
    super.key,
    required this.house,
  });

  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    return Text(
      house.address.description,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: ProjectColors.kWhite,
        fontSize: 18,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class FadeImageWidget extends StatefulWidget {
  final Function onRetryPressed;

  const FadeImageWidget({
    Key? key,
    required this.model,
    required this.house,
    required this.onRetryPressed,
  }) : super(key: key);

  final AdminModel? model;
  final HouseEntity house;

  @override
  State<FadeImageWidget> createState() => _FadeImageWidgetState();
}

class _FadeImageWidgetState extends State<FadeImageWidget> {
  Uint8List? _imageBytes;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadAsync();
  }

  Future<void> _loadAsync() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final imageBytes =
          await widget.model!.loadImageBytes(widget.house.photos);

      setState(() {
        _imageBytes = imageBytes;
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 5,
      child: _isLoading
          ? const ShimmerImageWidget()
          : _hasError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: ProjectColors.kMediumGreen,
                          size: 32.0,
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Упс! Что-то пошло не так',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.kWhite,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Не удается загрузить фото',
                          style: TextStyle(fontSize: 8.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ProjectColors.kLightGreen),
                          onPressed: () {
                            widget.onRetryPressed();
                          },
                          child: const Text(
                            'Повторить попытку',
                            style: TextStyle(fontSize: 8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Image.memory(
                  _imageBytes ?? kTransparentImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
    );
  }
}

class ShimmerImageWidget extends StatelessWidget {
  const ShimmerImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 5,
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.3),
        highlightColor: Colors.black.withOpacity(0.1),
        child: Container(
          width: double.maxFinite,
          color: Colors.black.withOpacity(0.1),
        ),
      ),
    );
  }
}

class SavedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SavedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'Админ-панель',
        style: TextStyle(
          letterSpacing: 0.5,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ProjectColors.kTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
