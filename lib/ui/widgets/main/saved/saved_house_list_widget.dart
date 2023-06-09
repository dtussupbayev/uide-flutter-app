import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/domain/models/house_entity/photo.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/main/saved/saved_house_list_model.dart';

import '../../../../provider/project_provider.dart';
import '../../../../../utils/search_bar.dart';

class SavedHouseListWidget extends StatefulWidget {
  const SavedHouseListWidget({super.key});

  @override
  State<SavedHouseListWidget> createState() => _SavedHouseListWidgetState();
}

class _SavedHouseListWidgetState extends State<SavedHouseListWidget>
    with SingleTickerProviderStateMixin {
  final model = SavedHouseListModel();

  @override
  void initState() {
    super.initState();

    model.setupHouses(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    model.setupHouses(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<SavedHouseListModel>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            appBar: const SavedAppBar(),
            extendBody: true,
            backgroundColor: ProjectColors.kTransparent,
            body: model!.isContentEmpty
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
                            'У вас пока нет домов в избранных',
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
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.76,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const SearchBarWidget(
                            hint: 'Поиск в избранных...',
                          ),
                          model.houses.isEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      Shimmer.fromColors(
                                        baseColor: ProjectColors.kBlack
                                            .withOpacity(0.6),
                                        highlightColor: ProjectColors.kBlack
                                            .withOpacity(0.3),
                                        child: SizedBox(
                                          width: 350,
                                          height: 350,
                                          child: Padding(
                                            padding: kHouseItemPadding,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    ProjectColors.kTransparent,
                                                border: Border.all(
                                                    color: ProjectColors.kBlack
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ProjectColors.kBlack
                                                        .withOpacity(0.2),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                            ),
                                          ),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: 2)
                              : ListView.separated(
                                  padding: const EdgeInsets.only(bottom: 70),
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: model.houses.length,
                                  itemBuilder: (context, index) {
                                    final house = model.houses[index];

                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 350,
                                          child: HouseItem(
                                            house: house,
                                            onTap: () => model.onHouseTap(
                                                context, index),
                                            onLikeTap: () => {},
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}

class HouseItem extends StatefulWidget {
  final HouseEntity house;

  final VoidCallback onTap;
  final VoidCallback onLikeTap;

  const HouseItem({
    Key? key,
    required this.house,
    required this.onTap,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  @override
  Widget build(BuildContext context) {
    String loadImageUrl(List<Photo>? image) {
      if (image!.isNotEmpty) {
        if (image.first.link !=
                'https://rent-house.s3.amazonaws.com/1681924531659-1681754004396-Screenshot%202023-04-13%20at%2016.45.21.png' &&
            !image.contains(null) &&
            image.isNotEmpty) {
          if (image.first.link ==
              '"https://rent-house-main.s3.ap-south-1.amazonaws.com/1685484765494-bedroom_1.jpg"') {
            String imageLink = image.first.link as String;
            return imageLink.substring(1, imageLink.length - 1);
          }
          return image.first.link as String;
        } else {
          return 'https://www.pngkey.com/png/detail/233-2332677_ega-png.png';
        }
      } else {
        return 'https://www.pngkey.com/png/detail/233-2332677_ega-png.png';
      }
    }

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
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 11 / 5,
                      child: Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(0.3),
                        highlightColor: Colors.black.withOpacity(0.1),
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 11 / 5,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: loadImageUrl(widget.house.photos),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (_, __, ___) {
                          // setState(() {
                          //   _isLoading = false;
                          // });
                          return Container(); // or an error placeholder widget
                        },
                        fadeInDuration: const Duration(milliseconds: 1000),
                        fadeOutDuration: const Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 200,
                        // Optional: You can specify additional parameters like alignment, repeat, etc.
                      ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.house.address.description,
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
                          widget.house.description,
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
                          '${widget.house.price} тг/месяц',
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
              onTap: widget.onTap,
            ),
          ),
          // Positioned(
          //   right: 22,
          //   bottom: 22,
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //       color: ProjectColors.kTransparent,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 2.5),
          //       child: LikeButton(
          //         isLiked: widget.house.liked,
          //         likeBuilder: (isTapped) {
          //           return widget.house.liked
          //               ? const Icon(
          //                   Icons.favorite_rounded,
          //                   color: ProjectColors.kWhite,
          //                 )
          //               : const Icon(
          //                   Icons.favorite_border_rounded,
          //                   color: ProjectColors.kWhite,
          //                 );
          //         },
          //         onTap: (isTapped) async {
          //           setState(() {
          //             widget.house.liked = !widget.house.liked;
          //             widget.onLikeTap();
          //           });
          //           return !isTapped;
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
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
        'Избранное',
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
