import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../views/detail_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(id: recipe.id, name: recipe.name, img: recipe.imageUrl))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(recipe.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(recipe.category, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFFDB05E)),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}