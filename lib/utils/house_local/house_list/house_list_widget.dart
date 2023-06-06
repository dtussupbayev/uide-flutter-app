import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/local_data/houses_data.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/utils/search_bar.dart';
import 'package:like_button/like_button.dart';

class HouseListLocalWidget extends StatefulWidget {
  const HouseListLocalWidget({super.key});

  @override
  State<HouseListLocalWidget> createState() => _HouseListLocalWidgetState();
}

class _HouseListLocalWidgetState extends State<HouseListLocalWidget> {
  List<House> _houses = Houses.houses;
  late List<House> _filteredHouses;

  @override
  void initState() {
    super.initState();

    _houses = Houses.houses;
    _filteredHouses = _houses;
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void _filterHouses(String query) {
    setState(() {
      _filteredHouses = _houses.where(
        (house) {
          final title = house.title.toLowerCase();
          final description = house.description.toLowerCase();
          final searchQuery = query.toLowerCase();
          return title.contains(searchQuery) ||
              description.contains(searchQuery);
        },
      ).toList();
    });
  }

  void onHouseTap(int index) {
    final id = _filteredHouses[index].id;
    Navigator.of(context)
        .pushNamed(
          MainNavigationRouteNames.houseDetails,
          arguments: id,
        )
        .then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<HouseListModel>(context);
    // if (model == null) return const SizedBox.shrink();

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
                    hint: 'Поиск домов...',
                  ),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: _filteredHouses.length,
                    itemBuilder: (context, index) {
                      final house = _filteredHouses[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 350,
                            child: HouseItem(
                              house: house,
                              onTap: () => onHouseTap(index),
                            ),
                          ),
                        ],
                      );
                    },
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

class HouseItem extends StatelessWidget {
  final House house;
  final VoidCallback onTap;

  const HouseItem({
    Key? key,
    required this.house,
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
                  aspectRatio: 11 / 5,
                  child: Image(
                    image: AssetImage(house.image),
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
                                house.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.kWhite,
                                  fontSize: 18,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          house.description,
                          style: const TextStyle(
                            color: ProjectColors.kWhite,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 30),
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
                    ),
                  ),
                ),
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
                  isLiked: house.liked,
                  likeBuilder: (isTapped) {
                    return house.liked
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
                    house.liked = !house.liked;
                    return !isTapped;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
