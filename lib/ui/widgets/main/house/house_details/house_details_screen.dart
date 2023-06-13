import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_content.dart';
import 'package:like_button/like_button.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_model.dart';
import 'package:uide/ui/widgets/main/main_screen/main_screen_model.dart';
import 'package:uide/ui/widgets/main/main_screen/main_screen_widget.dart';
import 'package:uide/utils/connectivity_check_widget.dart';
import 'package:uide/utils/waiting_screen.dart';

class HouseDetailsScreen extends StatefulWidget {
  final String? houseId;
  final int? pageIndex;
  const HouseDetailsScreen(
      {super.key, required this.houseId, required this.pageIndex});

  @override
  State<HouseDetailsScreen> createState() => _HouseDetailsScreenState();
}

class _HouseDetailsScreenState extends State<HouseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<HouseDetailsModel>(context);
    final houseDetails = model?.houseDetails;
    SizedBox likeButtonWidget() {
      return SizedBox(
        height: 50,
        width: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: ProjectColors.kWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.5),
            child: LikeButton(
              animationDuration: const Duration(milliseconds: 2000),
              isLiked: model!.isSaved,
              bubblesColor: const BubblesColor(
                dotPrimaryColor: ProjectColors.kMediumGreen,
                dotSecondaryColor: ProjectColors.kDarkGreen,
                dotThirdColor: ProjectColors.kDarkerMediumGreen,
                dotLastColor: ProjectColors.kDarkGreen,
              ),
              likeBuilder: (isTapped) {
                return model.isSaved == true
                    ? const Icon(
                        Icons.favorite_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      )
                    : const Icon(
                        Icons.favorite_border_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      );
              },
              onTap: (isTapped) async {
                if (model.isSaved == true) {
                  model.deleteFromSaved(widget.houseId ?? 'dasda', context);
                } else {
                  model.addToSaved(widget.houseId ?? 'dasd', context);
                }
                return !isTapped;
              },
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.pageIndex == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConnectivityCheckWidget(
                      connectedWidget: ProjectNotifierProvider(
                          create: () => MainScreenModel(),
                          child: const MainScreenWidget(
                            selectedPageIndex: 1,
                          )),
                    )),
          );
        } else if (widget.pageIndex == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConnectivityCheckWidget(
                      connectedWidget: ProjectNotifierProvider(
                          create: () => MainScreenModel(),
                          child: const MainScreenWidget(
                            selectedPageIndex: 0,
                          )),
                    )),
          );
        }
        return true;
      },
      child: DecoratedBox(
        decoration: kMainBackgroundGradientDecoration,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ProjectColors.kTransparent,
            body: SafeArea(
              child: houseDetails == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ProjectColors.kLightGreen,
                      ),
                    )
                  : kIsWeb ||
                          Platform.isMacOS ||
                          Platform.isLinux ||
                          Platform.isWindows
                      ? _DesktopLayout(
                          model: model,
                          houseDetails: houseDetails,
                          widget: widget)
                      : _MobileLayout(
                          model: model,
                          houseDetails: houseDetails,
                          widget: widget),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    super.key,
    required this.model,
    required this.houseDetails,
    required this.widget,
  });

  final HouseDetailsModel? model;
  final HouseDetailsResponse? houseDetails;
  final HouseDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    SizedBox likeButtonWidget() {
      return SizedBox(
        height: 50,
        width: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: ProjectColors.kWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.5),
            child: LikeButton(
              animationDuration: const Duration(milliseconds: 2000),
              isLiked: model!.isSaved,
              bubblesColor: const BubblesColor(
                dotPrimaryColor: ProjectColors.kMediumGreen,
                dotSecondaryColor: ProjectColors.kDarkGreen,
                dotThirdColor: ProjectColors.kDarkerMediumGreen,
                dotLastColor: ProjectColors.kDarkGreen,
              ),
              likeBuilder: (isTapped) {
                return model!.isSaved == true
                    ? const Icon(
                        Icons.favorite_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      )
                    : const Icon(
                        Icons.favorite_border_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      );
              },
              onTap: (isTapped) async {
                if (model!.isSaved == true) {
                  model!.deleteFromSaved(widget.houseId ?? 'dasda', context);
                } else {
                  model!.addToSaved(widget.houseId ?? 'dasd', context);
                }
                return !isTapped;
              },
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Flexible(
          flex: 6,
          child: Stack(
            children: [
              HouseDetailsImageWidget(model: model, houseDetails: houseDetails),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 20,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowBackWidget(
                          pageIndex: widget.pageIndex,
                        ),
                        likeButtonWidget()
                      ]),
                ),
              ),
            ],
          ),
        ),
        const HouseDetailsContent(),
        Flexible(
          flex: 1,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: ProjectColors.kTransparent,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: SizedBox(
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
                    onPressed: () {},
                    child: const Text(
                      'Связаться',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.model,
    required this.houseDetails,
    required this.widget,
  });

  final HouseDetailsModel? model;
  final HouseDetailsResponse? houseDetails;
  final HouseDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    SizedBox likeButtonWidget() {
      return SizedBox(
        height: 50,
        width: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: ProjectColors.kWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.5),
            child: LikeButton(
              animationDuration: const Duration(milliseconds: 2000),
              isLiked: model!.isSaved,
              bubblesColor: const BubblesColor(
                dotPrimaryColor: ProjectColors.kMediumGreen,
                dotSecondaryColor: ProjectColors.kDarkGreen,
                dotThirdColor: ProjectColors.kDarkerMediumGreen,
                dotLastColor: ProjectColors.kDarkGreen,
              ),
              likeBuilder: (isTapped) {
                return model!.isSaved == true
                    ? const Icon(
                        Icons.favorite_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      )
                    : const Icon(
                        Icons.favorite_border_rounded,
                        size: 22,
                        color: ProjectColors.kDarkGreen,
                      );
              },
              onTap: (isTapped) async {
                if (model!.isSaved == true) {
                  model!.deleteFromSaved(widget.houseId ?? 'dasda', context);
                } else {
                  model!.addToSaved(widget.houseId ?? 'dasd', context);
                }
                return !isTapped;
              },
            ),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4 * 3 / 4,
                  child: Stack(
                    children: [
                      DesktopHouseDetailsImageWidget(
                          model: model, houseDetails: houseDetails),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 20,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ArrowBackWidget(
                                  pageIndex: widget.pageIndex,
                                ),
                                likeButtonWidget()
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const DesktopHouseDetailsContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowBackWidget extends StatelessWidget {
  final int? pageIndex;
  const ArrowBackWidget({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (pageIndex == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConnectivityCheckWidget(
                      connectedWidget: ProjectNotifierProvider(
                          create: () => MainScreenModel(),
                          child: const MainScreenWidget(
                            selectedPageIndex: 1,
                          )),
                    )),
          );
        } else if (pageIndex == 0) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ConnectivityCheckWidget(
                        connectedWidget: ProjectNotifierProvider(
                            create: () => MainScreenModel(),
                            child: const MainScreenWidget(
                              selectedPageIndex: 0,
                            )),
                      )),
              (route) => false);
        }
      },
      child: SizedBox(
        height: 52.5,
        width: 52.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: ProjectColors.kWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12)),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: ProjectColors.kDarkGreen,
          ),
        ),
      ),
    );
  }
}

class HouseDetailsImageWidget extends StatelessWidget {
  const HouseDetailsImageWidget({
    super.key,
    required this.model,
    required this.houseDetails,
  });

  final HouseDetailsModel? model;
  final HouseDetailsResponse? houseDetails;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: model!.loadImageUrl(houseDetails!.photos),
      imageErrorBuilder: (context, error, stackTrace) {
        return const ConnectionWaitingScreen();
      },

      fit: BoxFit.cover,

      fadeInDuration: const Duration(milliseconds: 1000),
      fadeOutDuration: const Duration(milliseconds: 1000),
      width: MediaQuery.of(context).size.width,
      // Optional: You can specify additional parameters like alignment, repeat, etc.
    );
  }
}

class DesktopHouseDetailsImageWidget extends StatelessWidget {
  const DesktopHouseDetailsImageWidget({
    super.key,
    required this.model,
    required this.houseDetails,
  });

  final HouseDetailsModel? model;
  final HouseDetailsResponse? houseDetails;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: model!.loadImageUrl(houseDetails!.photos),
      imageErrorBuilder: (context, error, stackTrace) {
        return const ConnectionWaitingScreen();
      },
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 1000),
      fadeOutDuration: const Duration(milliseconds: 1000),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 3 / 4,
    );
  }
}
