import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';
import 'package:uide/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/house/house_list/house_list_model.dart';
import 'package:uide/utils/search_bar.dart';
import '../../../../theme/project_styles.dart';
import 'package:transparent_image/transparent_image.dart';

class HouseListWidget extends StatefulWidget {
  const HouseListWidget({super.key});

  @override
  State<HouseListWidget> createState() => _HouseListWidgetState();
}

class _HouseListWidgetState extends State<HouseListWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: kMainBackgroundGradientDecoration,
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
                const SearchBarWidget(hint: 'Поиск домов...'),
                model.isContentEmpty == true
                    ? const SizedBox.shrink()
                    : model.houses.isEmpty
                        ? const ShimmerHousesListViewWidget()
                        : HousesListViewWidget(model: model),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HousesListViewWidget extends StatelessWidget {
  const HousesListViewWidget({
    super.key,
    required this.model,
  });

  final HouseListModel? model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: model!.houses.length,
      itemBuilder: (context, index) {
        model!.showedHouseAtIndex(index, context);
        final house = model!.houses[index];
        return Column(
          children: [
            SizedBox(
              height: 350,
              child: HouseItem(
                house: house,
                onTap: () => model!.onHouseTap(context, index),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
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
            baseColor: ProjectColors.kBlack.withOpacity(0.6),
            highlightColor: ProjectColors.kBlack.withOpacity(0.3),
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

class HouseItem extends StatelessWidget {
  final HouseEntity house;
  final VoidCallback onTap;

  const HouseItem({
    Key? key,
    required this.house,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<HouseListModel>(context);

    bool isLikedHouse = false;

    return Padding(
      padding: kHouseItemPadding,
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
                    FadeImageWidget(model: model, house: house),
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
                  isLiked: isLikedHouse, // house.liked,
                  likeBuilder: (isTapped) {
                    return isLikedHouse
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
                    isLikedHouse = !isLikedHouse;
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

class HousePriceWidget extends StatelessWidget {
  const HousePriceWidget({
    super.key,
    required this.house,
  });

  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
      ),
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

class FadeImageWidget extends StatelessWidget {
  const FadeImageWidget({
    super.key,
    required this.model,
    required this.house,
  });

  final HouseListModel? model;
  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 5,
      child: !model!.isConnected
          ? Image.memory(kTransparentImage)
          : FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: model!.loadImageUrl(house.photos),
              fit: BoxFit.cover,
              imageErrorBuilder: (_, __, ___) {
                return Container(); // or an error placeholder widget
              },
              fadeInDuration: const Duration(milliseconds: 1000),
              fadeOutDuration: const Duration(milliseconds: 1000),
              width: double.infinity,
              height: 200,
              // Optional: You can specify additional parameters like alignment, repeat, etc.
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
