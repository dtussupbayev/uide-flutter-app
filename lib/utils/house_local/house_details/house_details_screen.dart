import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/utils/house_local/house_details/house_details_content.dart';
import 'package:uide/local_data/houses_data.dart';
import 'package:like_button/like_button.dart';

class HouseDetailsScreenLocal extends StatefulWidget {
  final int houseId;
  const HouseDetailsScreenLocal({super.key, required this.houseId});

  @override
  State<HouseDetailsScreenLocal> createState() =>
      _HouseDetailsScreenLocalState();
}

class _HouseDetailsScreenLocalState extends State<HouseDetailsScreenLocal> {
  late House house;
  @override
  void initState() {
    super.initState();
    house = Houses.houses.firstWhere((house) => house.id == widget.houseId);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ProjectColors.kTransparent,
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image(
                          image: AssetImage(house.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 52.5,
                                  width: 52.5,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: ProjectColors.kWhite
                                            .withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(
                                      Icons.arrow_back_rounded,
                                      color: ProjectColors.kDarkGreen,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:
                                          ProjectColors.kWhite.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2.5),
                                    child: LikeButton(
                                      isLiked: house.liked,
                                      bubblesColor: const BubblesColor(
                                        dotPrimaryColor:
                                            ProjectColors.kMediumGreen,
                                        dotSecondaryColor:
                                            ProjectColors.kDarkGreen,
                                        dotThirdColor:
                                            ProjectColors.kDarkerMediumGreen,
                                        dotLastColor: ProjectColors.kDarkGreen,
                                      ),
                                      likeBuilder: (isTapped) {
                                        return house.liked
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
                                          house.liked = !house.liked;
                                        });
                                        return !isTapped;
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                HouseDetailsContent(house)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
