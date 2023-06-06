import 'package:flutter/material.dart';
import 'package:uide/local_data/roommates_data.dart';
import 'package:uide/ui/theme/project_colors.dart';

class RoommateDetailsContent extends StatefulWidget {
  final Roommate roommate;

  const RoommateDetailsContent(this.roommate, {super.key});

  @override
  RoommateDetailsContentState createState() => RoommateDetailsContentState();
}

class RoommateDetailsContentState extends State<RoommateDetailsContent> {
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.roommate.budget} тг/месяц',
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
                  widget.roommate.title,
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
              'Сведения',
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
                            '${widget.roommate.age}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.kWhite),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Возраст',
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
              bottom: 20 * 4,
            ),
            child: Text(
              widget.roommate.description,
              style: TextStyle(
                color: ProjectColors.kWhite.withOpacity(0.4),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
