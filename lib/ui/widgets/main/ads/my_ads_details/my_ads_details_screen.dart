import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uide/models/house_details_response/house_details_response.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_content.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_model.dart';
import 'package:like_button/like_button.dart';

class MyAdsDetailsScreen extends StatefulWidget {
  final String houseId;
  const MyAdsDetailsScreen({super.key, required this.houseId});

  @override
  State<MyAdsDetailsScreen> createState() => _MyAdsDetailsScreenState();
}

class _MyAdsDetailsScreenState extends State<MyAdsDetailsScreen> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    ProjectNotifierProvider.read<MyAdsDetailsModel>(context)
        ?.loadDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<MyAdsDetailsModel>(context);
    final houseDetails = model?.houseDetails;

    return DecoratedBox(
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
                      const MyAdsDetailsContent(),
                      Flexible(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 4,
                                ),
                                child: Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ProjectColors.kMediumGreen,
                                      border: Border.all(
                                        color: ProjectColors.kBlack
                                            .withOpacity(0.1),
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
                                        'Изменить',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, left: 4),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCE2332),
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
                                    onPressed: () =>
                                        model?.onDeleteTap(context),
                                    child: const Text(
                                      'Удалить',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

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
            isLiked: isLiked,
            bubblesColor: const BubblesColor(
              dotPrimaryColor: ProjectColors.kMediumGreen,
              dotSecondaryColor: ProjectColors.kDarkGreen,
              dotThirdColor: ProjectColors.kDarkerMediumGreen,
              dotLastColor: ProjectColors.kDarkGreen,
            ),
            likeBuilder: (isTapped) {
              return isLiked
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
              setState(() {
                isLiked = !isLiked;
              });
              return !isTapped;
            },
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
        Navigator.pop(context);
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

  final MyAdsDetailsModel? model;
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
