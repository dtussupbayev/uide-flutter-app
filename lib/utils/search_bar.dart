import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final String? hint;
  final Function(String)? onSearch;
  final VoidCallback? onToggleFilter;
  final bool ifHideFilterIcon;

  const SearchBarWidget({
    Key? key,
    required this.hint,
    this.onSearch,
    this.onToggleFilter,
    this.ifHideFilterIcon = false,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  onChanged: widget.onSearch,
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
                            onPressed: () {
                              searchController.clear();
                              widget.onSearch?.call('');
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
          widget.ifHideFilterIcon
              ? SizedBox.shrink()
              : SizedBox(
                  height: kFilterIconSize,
                  width: kFilterIconSize,
                  child: IconButton(
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        color: ProjectColors.kWhite,
                      ),
                      onPressed: widget.onToggleFilter),
                )
        ],
      ),
    );
  }
}
