import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uide/models/house_list_entity_response/house_entity.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/house/house_list/house_list_model.dart';
import 'package:uide/utils/search_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class HouseListWidget extends StatefulWidget {
  final Function onRetryPressed;
  final bool? isFilterMenuOpen;
  final VoidCallback toggleFilterMenu;

  const HouseListWidget({
    super.key,
    required this.onRetryPressed,
    required this.isFilterMenuOpen,
    required this.toggleFilterMenu,
  });

  @override
  State<HouseListWidget> createState() => _HouseListWidgetState();
}

class _HouseListWidgetState extends State<HouseListWidget> {
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

  final HouseListWidget widget;

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    void performSearch(String searchString) {
      model.searchString = searchString;
      model.setupHouses(context);
    }

    void toggleFilterMenu() {
      model.toggleFilterMenu();
    }

    var windowWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: kMainBackgroundGradientDecoration.gradient,
            boxShadow: model.isFilterMenuOpen
                ? [
                    const BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            top: true,
            bottom: false,
            child: Scaffold(
              extendBody: true,
              backgroundColor: ProjectColors.kTransparent,
              body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SearchBarWidget(
                        hint: 'Поиск домов...',
                        onSearch: performSearch,
                        onToggleFilter: toggleFilterMenu,
                      ),
                      const SizedBox(height: 20),
                      model.isContentEmpty
                          ? const SizedBox.shrink()
                          : model.filteredHouses.isEmpty
                              ? const DesktopLayoutShimmerHousesListViewWidget()
                              : Stack(
                                  children: [
                                    DesktopLayoutHousesListViewWidget(
                                      model: model,
                                      onRetryPressed: widget.onRetryPressed,
                                    ),
                                    if (model.isFilterMenuOpen)
                                      ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            color: ProjectColors.kTransparent,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                    ],
                  )),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          right: model.isFilterMenuOpen
              ? 0
              : windowWidth > 900
                  ? -windowWidth * 0.3
                  : -windowWidth * 0.5,
          top: 90,
          child: Container(
            width: windowWidth > 900 ? windowWidth * 0.3 : windowWidth * 0.5,
            height: 365,
            decoration: const BoxDecoration(
              color: ProjectColors.kDarkerDarkGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 22.0,
                        left: 24.0,
                      ),
                      child: Text(
                        'Фильтры',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 22.0,
                        right: 24.0,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: ProjectColors.kWhite,
                        ),
                        onPressed: toggleFilterMenu,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        'Цена',
                        style: TextStyle(
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: RangeSlider(
                        activeColor: ProjectColors.kMediumGreen,
                        values: model.priceRangeValues,
                        min: model.initialPriceRangeValues.start,
                        max: model.initialPriceRangeValues.end,
                        onChanged: (RangeValues values) {
                          model.setPriceRangeValues(values);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model.priceRangeValues.start.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                          Text(
                            '${model.priceRangeValues.end.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        'Количество жителей',
                        style: TextStyle(
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          minThumbSeparation: 10,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(
                              elevation: 10.0, enabledThumbRadius: 50.0),
                        ),
                        child: RangeSlider(
                          activeColor: ProjectColors.kMediumGreen,
                          values: model.residencesRangeValues,
                          min: model.initialResidencesRangeValues.start,
                          max: model.initialResidencesRangeValues.end,
                          divisions: (model.initialResidencesRangeValues.end -
                                      model.initialResidencesRangeValues
                                          .start) ==
                                  0
                              ? 1
                              : (model.initialResidencesRangeValues.end -
                                      model.initialResidencesRangeValues.start)
                                  .toInt(),
                          onChanged: (RangeValues values) {
                            model.setResidentsRangeValues(values);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model.residencesRangeValues.start.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                          Text(
                            '${model.residencesRangeValues.end.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    right: 16.0,
                    left: 16.0,
                  ),
                  child: SizedBox(
                    width: windowWidth > 800
                        ? windowWidth * 0.3
                        : windowWidth * 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ProjectColors.kMediumGreen,
                        border: Border.all(
                            color: ProjectColors.kBlack.withOpacity(0.05)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: ProjectColors.kBlack.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          elevation: 0,
                          side: const BorderSide(
                            width: 0,
                            color: ProjectColors.kTransparent,
                          ),
                          foregroundColor: ProjectColors.kWhite,
                          backgroundColor: ProjectColors.kTransparent,
                        ),
                        onPressed: () async {
                          await model.setupHousesWithFilters(context);
                          toggleFilterMenu();
                        },
                        child: model.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  color: ProjectColors.kWhite,
                                ),
                              )
                            : const Text(
                                'Показать результаты',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.widget,
  });

  final HouseListWidget widget;

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    void performSearch(String searchString) {
      model.searchString = searchString;
      model.setupHouses(context);
    }

    void toggleFilterMenu() {
      model.toggleFilterMenu();
      widget.toggleFilterMenu();
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: kMainBackgroundGradientDecoration.gradient,
            boxShadow: model.isFilterMenuOpen
                ? [
                    const BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            top: true,
            bottom: false,
            child: Scaffold(
              extendBody: true,
              backgroundColor: ProjectColors.kTransparent,
              body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SearchBarWidget(
                        hint: 'Поиск домов...',
                        onSearch: performSearch,
                        onToggleFilter: toggleFilterMenu,
                      ),
                      model.isContentEmpty
                          ? const SizedBox.shrink()
                          : model.filteredHouses.isEmpty
                              ? const ShimmerHousesListViewWidget()
                              : Stack(
                                  children: [
                                    HousesListViewWidget(
                                      model: model,
                                      onRetryPressed: widget.onRetryPressed,
                                    ),
                                    if (model.isFilterMenuOpen)
                                      ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 300.0,
                                            color: ProjectColors.kTransparent,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                    ],
                  )),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          bottom: model.isFilterMenuOpen ? 0 : -365,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 365,
            decoration: const BoxDecoration(
              color: ProjectColors.kDarkerDarkGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 22.0,
                        left: 24.0,
                      ),
                      child: Text(
                        'Фильтры',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 22.0,
                        right: 24.0,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: ProjectColors.kWhite,
                        ),
                        onPressed: toggleFilterMenu,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        'Цена',
                        style: TextStyle(
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: RangeSlider(
                        activeColor: ProjectColors.kMediumGreen,
                        values: model.priceRangeValues,
                        min: model.initialPriceRangeValues.start,
                        max: model.initialPriceRangeValues.end,
                        onChanged: (RangeValues values) {
                          model.setPriceRangeValues(values);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model.priceRangeValues.start.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                          Text(
                            '${model.priceRangeValues.end.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        'Количество жителей',
                        style: TextStyle(
                          color: ProjectColors.kWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          minThumbSeparation: 10,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(
                              elevation: 10.0, enabledThumbRadius: 50.0),
                        ),
                        child: RangeSlider(
                          activeColor: ProjectColors.kMediumGreen,
                          values: model.residencesRangeValues,
                          min: model.initialResidencesRangeValues.start,
                          max: model.initialResidencesRangeValues.end,
                          divisions: (model.initialResidencesRangeValues.end -
                                      model.initialResidencesRangeValues
                                          .start) ==
                                  0
                              ? 1
                              : (model.initialResidencesRangeValues.end -
                                      model.initialResidencesRangeValues.start)
                                  .toInt(),
                          onChanged: (RangeValues values) {
                            model.setResidentsRangeValues(values);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model.residencesRangeValues.start.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                          Text(
                            '${model.residencesRangeValues.end.toInt()}',
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ProjectColors.kMediumGreen,
                        border: Border.all(
                            color: ProjectColors.kBlack.withOpacity(0.05)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: ProjectColors.kBlack.withOpacity(0.1),
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
                        onPressed: () async {
                          await model.setupHousesWithFilters(context);
                          toggleFilterMenu();
                        },
                        child: model.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  color: ProjectColors.kWhite,
                                ),
                              )
                            : const Text(
                                'Показать результаты',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  final HouseListModel? model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: model!.filteredHouses.length,
      itemBuilder: (context, index) {
        model!.showedHouseAtIndex(index, context);
        final house = model!.filteredHouses[index];
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

  final HouseListModel? model;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int determineCrossAxisCount() {
      if (screenWidth > 1000) {
        return 3;
      } else if (screenWidth > 502) {
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
            crossAxisSpacing: screenWidth > 800 ? 30 : 10,
            mainAxisSpacing: 30),
        padding: const EdgeInsets.only(bottom: 50),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: model!.filteredHouses.length,
        itemBuilder: (context, index) {
          model!.showedHouseAtIndex(index, context);
          final house = model!.filteredHouses[index];
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
    final screenWidth = MediaQuery.of(context).size.width;

    int determineCrossAxisCount() {
      if (screenWidth > 1000) {
        return 3;
      } else if (screenWidth > 502) {
        return 2;
      } else {
        return 1;
      }
    }

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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: determineCrossAxisCount(),
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
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);

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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.5),
                    child: LikeButton(
                      isLiked: model!.checkIsSaved(house.id, context),
                      likeBuilder: (isTapped) {
                        return model.checkIsSaved(house.id, context)
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: ProjectColors.kWhite,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                                color: ProjectColors.kWhite,
                              );
                      },
                      onTap: (isTapped) async {
                        if (model.checkIsSaved(house.id, context)) {
                          model.deleteFromSaved(house.id, context);
                        } else {
                          model.addToSaved(house.id, context);
                        }
                        return !isTapped;
                      },
                    ),
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
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);

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
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: LikeButton(
                    isLiked: model!.checkIsSaved(house.id, context),
                    likeBuilder: (isTapped) {
                      return model.checkIsSaved(house.id, context)
                          ? const Icon(
                              Icons.favorite_rounded,
                              color: ProjectColors.kWhite,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                              color: ProjectColors.kWhite,
                            );
                    },
                    onTap: (isTapped) async {
                      if (model.checkIsSaved(house.id, context)) {
                        model.deleteFromSaved(house.id, context);
                      } else {
                        model.addToSaved(house.id, context);
                      }
                      return !isTapped;
                    },
                  ),
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
    return Flexible(
      child: Text(
        house.address.description,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ProjectColors.kWhite,
          fontSize: 18,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
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

  final HouseListModel? model;
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
