import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';

import '../../../local_data/houses_data.dart';

class HouseDetailsContent extends StatefulWidget {
  final House house;

  const HouseDetailsContent(this.house, {super.key});

  @override
  HouseDetailsContentState createState() => HouseDetailsContentState();
}

class HouseDetailsContentState extends State<HouseDetailsContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      '${widget.house.price} тг/месяц',
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
                  widget.house.title,
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '40',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.kWhite),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Bedrooms',
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1',
                            style: TextStyle(
                              color: ProjectColors.kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Bathrooms',
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.kWhite),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Garages',
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
              bottom: 20 * 5,
            ),
            child: Text(
              widget.house.description,
              style: TextStyle(
                color: ProjectColors.kWhite.withOpacity(0.4),
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
        ],
      ),
    );
  }
}
