import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

import 'project_colors.dart';

const double kFilterIconSize = 49.0;
const double kBorderRadius = 20.0;

final kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: const BorderSide(
      color: ProjectColors.kTransparent,
    ));

final BackdropFilter kMainFilter = BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  child: DecoratedBox(
    decoration: BoxDecoration(
      color: ProjectColors.kBlack.withOpacity(0.3),
    ),
  ),
);

final InputDecoration kDefaultInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
  border: kInputBorder,
  focusedBorder: kInputBorder,
  enabledBorder: kInputBorder,
  hintStyle: TextStyle(
    fontSize: 16,
    color: ProjectColors.kWhite.withOpacity(0.4),
  ),
);

const LinearGradient kMainBottomNavigationIconGradient = LinearGradient(
  colors: [
    ProjectColors.kLightGreen,
    ProjectColors.kDarkGreen,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.bottomCenter,
);

final ButtonStyle kElevatedButtonPrimary = ElevatedButton.styleFrom(
  foregroundColor: ProjectColors.kMediumGreen,
  backgroundColor: ProjectColors.kWhite,
  elevation: 0,
  side: const BorderSide(width: 0.8, color: ProjectColors.kMediumGreen),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  ),
);

// Constants for padding
const EdgeInsets kHouseItemPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const EdgeInsets kRoomListPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 10);

// BoxDecoration styles

final BoxDecoration kBottomNavigationBarDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      ProjectColors.kDarkerMediumGreen.withOpacity(0.9),
      ProjectColors.kDarkGreen.withOpacity(0.9),
      ProjectColors.kDarkerDarkGreen.withOpacity(0.9),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.repeated,
  ),
  boxShadow: [
    BoxShadow(
      color: ProjectColors.kWhite.withOpacity(0.4),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ],
);

final kInnerDecoration = BoxDecoration(
  color: ProjectColors.kTransparent,
  border: Border.all(color: ProjectColors.kTransparent),
  borderRadius: BorderRadius.circular(10),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      const Color(0xFF004F29).withOpacity(0.4),
      const Color(0xFF004F29)
          .withOpacity(0.4), // A slightly darker shade of green
      const Color(0xFF0A6D42).withOpacity(0.4), // A darker green color
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    tileMode: TileMode.mirror,
  ),
  border: Border.all(color: ProjectColors.kBlack.withOpacity(0.05)),
  borderRadius: const BorderRadius.all(Radius.circular(20)),
  boxShadow: [
    BoxShadow(
      color: ProjectColors.kBlack.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    )
  ],
);

const BoxDecoration kMainBackgroundGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      ProjectColors.kDarkerLightGreen, // A light green color
      ProjectColors.kMediumGreen, // A medium green color
      ProjectColors.kDarkGreen, // A darker green color
      ProjectColors.kDarkerDarkGreen, // A darker green color
      ProjectColors.kDarkColor
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    tileMode: TileMode.mirror,
  ),
);

final PickerDialogStyle kCountryPickerDialogStyle = PickerDialogStyle(
  searchFieldInputDecoration: InputDecoration(
      border: kInputBorder,
      focusedBorder: kInputBorder,
      enabledBorder: kInputBorder,
      floatingLabelStyle: const TextStyle(color: ProjectColors.kMediumGreen),
      hintStyle: TextStyle(
        fontSize: 16,
        color: ProjectColors.kWhite.withOpacity(0.4),
      ),
      suffixIcon: const Icon(
        Icons.search_outlined,
        color: ProjectColors.kGrey,
      ),
      labelText: 'Поиск стран'),
  searchFieldCursorColor: ProjectColors.kMediumGreen,
);

final kHouseItemBoxDecoration = BoxDecoration(
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
);

final kShimmerHouseListViewDecoration = BoxDecoration(
  color: ProjectColors.kTransparent,
  border: Border.all(color: ProjectColors.kBlack.withOpacity(0.1)),
  borderRadius: const BorderRadius.all(Radius.circular(30)),
  boxShadow: [
    BoxShadow(
      color: ProjectColors.kBlack.withOpacity(0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
);
