import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final String? hint;

  const SearchBarWidget({
    super.key,
    required this.hint,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();

  // void _clearTextField() {
  //   searchController.clear();
  //   widget.filter(searchController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kRoomListPadding,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: kGradientBoxDecoration.copyWith(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DecoratedBox(
                decoration: kInnerDecoration,
                child: TextField(
                  style: TextStyle(
                    color: ProjectColors.kWhite.withOpacity(0.7),
                  ),
                  controller: searchController,
                  onChanged: (String) {},
                  decoration: kDefaultInputDecoration.copyWith(
                    hintText: widget.hint,
                    prefixIcon: const IconTheme(
                      data: IconThemeData(color: ProjectColors.kWhite),
                      child: Icon(
                        Icons.search_rounded,
                        weight: 200,
                      ),
                    ),
                    suffixIcon: searchController.text.isEmpty
                        ? null // Show nothing if the text field is empty
                        : IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: ProjectColors.kWhite,
                            ),
                            onPressed: () {},
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: kFilterIconSize,
            width: kFilterIconSize,
            child: Icon(
              Icons.filter_list_rounded,
              color: ProjectColors.kWhite,
            ),
          )
        ],
      ),
    );
  }
}
