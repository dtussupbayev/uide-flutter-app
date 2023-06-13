import 'package:flutter/material.dart';

class FilterMenu extends StatefulWidget {
  final Function(int minPrice, int maxPrice, int minResidents, int maxResidents)
      onFilter;

  const FilterMenu({Key? key, required this.onFilter}) : super(key: key);

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  RangeValues _selectedPriceRange = const RangeValues(100, 500);
  RangeValues _selectedResidentsRange = const RangeValues(2, 5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'Price Range: ${_selectedPriceRange.start} - ${_selectedPriceRange.end}'),
        RangeSlider(
          values: _selectedPriceRange,
          min: 0,
          max: 1000,
          divisions: 10,
          onChanged: (RangeValues values) {
            setState(() {
              _selectedPriceRange = values;
            });
            widget.onFilter(
              _selectedPriceRange.start.toInt(),
              _selectedPriceRange.end.toInt(),
              _selectedResidentsRange.start.toInt(),
              _selectedResidentsRange.end.toInt(),
            );
          },
        ),
        Text(
            'Number of Residents Range: ${_selectedResidentsRange.start.toInt()} - ${_selectedResidentsRange.end.toInt()}'),
        RangeSlider(
          values: _selectedResidentsRange,
          min: 1,
          max: 10,
          divisions: 9,
          onChanged: (RangeValues values) {
            setState(() {
              _selectedResidentsRange = values;
            });
            widget.onFilter(
              _selectedPriceRange.start.toInt(),
              _selectedPriceRange.end.toInt(),
              _selectedResidentsRange.start.toInt(),
              _selectedResidentsRange.end.toInt(),
            );
          },
        ),
      ],
    );
  }
}
