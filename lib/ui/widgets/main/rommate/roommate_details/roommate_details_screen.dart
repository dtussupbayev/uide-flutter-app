import 'package:flutter/material.dart';
import 'package:uide/local_data/roommates_data.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_details/roommate_details_content.dart';
import 'package:like_button/like_button.dart';

import '../../../../theme/project_styles.dart';

class RoommateDetailsScreen extends StatefulWidget {
  final int roommateId;
  const RoommateDetailsScreen({super.key, required this.roommateId});

  @override
  State<RoommateDetailsScreen> createState() => _RoommateDetailsScreenState();
}

class _RoommateDetailsScreenState extends State<RoommateDetailsScreen> {
  late Roommate roommate;
  @override
  void initState() {
    super.initState();
    roommate = Roommates.roommates
        .firstWhere((roommate) => roommate.id == widget.roommateId);
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
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Image(
                          image: AssetImage(roommate.image),
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
                                      isLiked: roommate.liked,
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
                                        return roommate.liked
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
                                          roommate.liked = !roommate.liked;
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
                RoommateDetailsContent(roommate)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
