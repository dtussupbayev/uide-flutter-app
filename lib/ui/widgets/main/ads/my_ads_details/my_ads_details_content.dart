import 'package:flutter/material.dart';
import 'package:uide/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/ads/my_ads_details/my_ads_details_model.dart';

class MyAdsDetailsContent extends StatefulWidget {
  const MyAdsDetailsContent({super.key});

  @override
  MyAdsDetailsContentState createState() => MyAdsDetailsContentState();
}

class MyAdsDetailsContentState extends State<MyAdsDetailsContent> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<MyAdsDetailsModel>(context);
    final houseDetails = model?.houseDetails;

    return Expanded(
      flex: 9,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${houseDetails?.price} тг/месяц',
                      style: const TextStyle(
                        color: ProjectColors.kWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '5 часов назад',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  houseDetails!.address?.description as String,
                  style: TextStyle(
                    fontSize: 16,
                    color: ProjectColors.kWhite.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Информация о жилье',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.kWhite),
            ),
          ),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                  ),
                  child: SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ProjectColors.kTransparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ProjectColors.kWhite.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            houseDetails.area.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.kWhite),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Площадь',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                  ),
                  child: SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ProjectColors.kTransparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ProjectColors.kWhite.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            houseDetails.floor.toString(),
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Этаж',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                  ),
                  child: SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ProjectColors.kTransparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ProjectColors.kWhite.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            houseDetails.numberOfResidents.toString(),
                            style: const TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Жители',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                  ),
                  child: SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ProjectColors.kTransparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ProjectColors.kWhite.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            houseDetails.numberOfRooms.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.kWhite),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Комнаты',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: Text(
              houseDetails.description as String,
              style: TextStyle(
                color: ProjectColors.kWhite.withOpacity(0.4),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Номер телефона автора: +7${houseDetails.author?.phoneNumber}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.kWhite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Почта автора: ${houseDetails.author?.email}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
