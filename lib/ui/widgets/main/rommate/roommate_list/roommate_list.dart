import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/utils/search_bar.dart';
import 'package:like_button/like_button.dart';

import '../../../../../local_data/roommates_data.dart';
import '../../../../theme/project_styles.dart';
import '../../../../theme/project_colors.dart';

class RoommateListWidget extends StatefulWidget {
  const RoommateListWidget({super.key});

  @override
  State<RoommateListWidget> createState() => _RoommateListWidgetState();
}

class _RoommateListWidgetState extends State<RoommateListWidget> {
  List<Roommate> _roommates = Roommates.roommates;
  late List<Roommate> _filteredRoommates;

  @override
  void initState() {
    super.initState();

    _roommates = Roommates.roommates;
    _filteredRoommates = _roommates;
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void onRoommateTap(int index) {
    final id = _filteredRoommates[index].id;
    Navigator.of(context)
        .pushNamed(
          MainNavigationRouteNames.roommateDetails,
          arguments: id,
        )
        .then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: ProjectColors.kTransparent,
          body: SizedBox(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const SearchBarWidget(
                    hint: 'Поиск соседей...',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 50),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: _filteredRoommates.length,
                      itemBuilder: (context, index) {
                        final roommate = _filteredRoommates[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 530,
                              child: RoommateItem(
                                roommate: roommate,
                                onTap: () => onRoommateTap(index),
                              ),
                            ),
                          ],
                        );
                      },
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

class RoommateItem extends StatelessWidget {
  final Roommate roommate;
  final VoidCallback onTap;

  const RoommateItem({
    Key? key,
    required this.roommate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kHouseItemPadding,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ProjectColors.kTransparent,
              border: Border.all(color: ProjectColors.kBlack.withOpacity(0.1)),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: ProjectColors.kBlack.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image(
                    image: AssetImage(roommate.image),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                '${roommate.name}, ${roommate.age}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.kWhite,
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        const Text(
                          'Бюджет',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${roommate.budget} тг/месяц',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: ProjectColors.kWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Material(
            color: ProjectColors.kTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onTap,
            ),
          ),
          Positioned(
            right: 22,
            bottom: 20,
            child: SizedBox(
              height: 40,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ProjectColors.kTransparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: LikeButton(
                    isLiked: roommate.liked,
                    likeBuilder: (isTapped) {
                      return roommate.liked
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
                      roommate.liked = !roommate.liked;
                      return !isTapped;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
