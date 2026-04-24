import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelect;

  const CategoryFilter({required this.categories, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          bool isSelected = categories[i] == selected;
          return GestureDetector(
            onTap: () => onSelect(categories[i]),
            child: Container(
              margin: EdgeInsets.only(left: i == 0 ? 20 : 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFDB05E) : Colors.white, // OREN KALEM
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFFDB05E).withOpacity(0.3)),
              ),
              child: Center(
                child: Text(
                  categories[i],
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}