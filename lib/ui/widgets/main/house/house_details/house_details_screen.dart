import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uide/domain/models/house_details_response/house_details_response.dart';
import 'package:uide/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_content.dart';
import 'package:like_button/like_button.dart';
import 'package:uide/ui/widgets/main/house/house_details/house_details_model.dart';

import '../../../../theme/project_styles.dart';

class HouseDetailsScreen extends StatefulWidget {
  final String houseId;
  const HouseDetailsScreen({super.key, required this.houseId});

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
                  model.deleteFromSaved(widget.houseId, context);
                } else {
                  model.addToSaved(widget.houseId, context);
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
        Navigator.pop(context, true);
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
                  : Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: Stack(
                            children: [
                              HouseDetailsImageWidget(
                                  model: model, houseDetails: houseDetails),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const ArrowBackWidget(),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 0),
                              child: SizedBox(
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
                                        color: ProjectColors.kBlack
                                            .withOpacity(0.1),
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
                                      backgroundColor:
                                          ProjectColors.kTransparent,
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
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context, true);
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
      fit: BoxFit.cover,

      fadeInDuration: const Duration(milliseconds: 1000),
      fadeOutDuration: const Duration(milliseconds: 1000),
      width: MediaQuery.of(context).size.width,
      // Optional: You can specify additional parameters like alignment, repeat, etc.
    );
  }
}
