import 'package:flutter/material.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/rommate/roommate_details/roommate_details_model.dart';

class RoommateDetailsContent extends StatefulWidget {
  const RoommateDetailsContent({super.key});

  @override
  State<RoommateDetailsContent> createState() => RoommateDetailsContentState();
}

class RoommateDetailsContentState extends State<RoommateDetailsContent> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<RoommateDetailsModel>(context);
    final roommateDetails = model?.roommateDetails;

    return ListView(
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
                    '${roommateDetails?.price} тг/месяц',
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
                roommateDetails!.address?.description as String,
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
                          roommateDetails.area.toString(),
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
                          roommateDetails.floor.toString(),
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
                          roommateDetails.numberOfResidents.toString(),
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
                          roommateDetails.numberOfRooms.toString(),
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
            roommateDetails.description as String,
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
            'Номер телефона автора: +7${roommateDetails.author?.phoneNumber}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ProjectColors.kWhite),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            'Почта автора: ${roommateDetails.author?.email}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ProjectColors.kWhite),
          ),
        ),
      ],
    );
  }
}

class DesktopRoommateDetailsContent extends StatefulWidget {
  const DesktopRoommateDetailsContent({super.key});

  @override
  State<DesktopRoommateDetailsContent> createState() =>
      DesktopRoommateDetailsContentState();
}

class DesktopRoommateDetailsContentState
    extends State<DesktopRoommateDetailsContent> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<RoommateDetailsModel>(context);
    final roommateDetails = model?.roommateDetails;

    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          '${roommateDetails?.price} тг/месяц',
          style: const TextStyle(
            color: ProjectColors.kWhite,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          roommateDetails!.address?.description as String,
          style: TextStyle(
            fontSize: 16,
            color: ProjectColors.kWhite.withOpacity(0.4),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Информация о жилье',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ProjectColors.kWhite),
        ),
        const SizedBox(height: 20),
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
                          roommateDetails.area.toString(),
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
                          roommateDetails.floor.toString(),
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
                          roommateDetails.numberOfResidents.toString(),
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
                          roommateDetails.numberOfRooms.toString(),
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
        const SizedBox(height: 20),
        Text(
          roommateDetails.description as String,
          style: TextStyle(
            color: ProjectColors.kWhite.withOpacity(0.4),
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Номер телефона автора: +7${roommateDetails.author?.phoneNumber}',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ProjectColors.kWhite),
        ),
        const SizedBox(height: 20),
        Text(
          'Почта автора: ${roommateDetails.author?.email}',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ProjectColors.kWhite),
        ),
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: ProjectColors.kTransparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
        ),
      ],
    );
  }
}
