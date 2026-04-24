import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/recipe_provider.dart';
import '../widgets/category_filter.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RecipeProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Food Recipe', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, elevation: 0, centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What recipe for today?',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFDB05E)),
                filled: true, fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
              onChanged: (v) => prov.search(v),
            ),
          ),
          CategoryFilter(categories: prov.categories, selected: prov.selectedCat, onSelect: (c) => prov.updateCat(c)),
          const SizedBox(height: 10),
          Expanded(
            child: prov.isLoading 
              ? _buildShimmer() 
              : prov.error.isNotEmpty 
                ? _buildError(prov.error)
                : ListView.builder(itemCount: prov.recipes.length, itemBuilder: (_, i) => RecipeCard(recipe: prov.recipes[i])),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
      child: ListView.builder(itemCount: 5, itemBuilder: (_, __) => Container(height: 100, margin: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)))),
    );
  }

  Widget _buildError(String msg) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.no_food, size: 80, color: Colors.grey), const SizedBox(height: 10), Text(msg)]));
  }
}