import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.onSelect,
  });

  final Category selectedCategory;
  final void Function(Category?) onSelect;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        onSelect(value);
      },
    );
  }
}
