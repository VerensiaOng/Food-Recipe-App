import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final String id, name, img;
  DetailScreen({required this.id, required this.name, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Recipe>(
        future: ApiService().fetchDetail(id),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFFDB05E)));
          final r = snap.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300, pinned: true, backgroundColor: const Color(0xFFFDB05E),
                flexibleSpace: FlexibleSpaceBar(background: Image.network(img, fit: BoxFit.cover)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Bahan-bahan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFDB05E))),
                      const SizedBox(height: 10),
                      ...r.ingredients!.map((e) => Text('• $e', style: const TextStyle(fontSize: 16, height: 1.5))),
                      const SizedBox(height: 25),
                      const Text('Instruksi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFDB05E))),
                      const SizedBox(height: 10),
                      Text(r.instructions!, style: const TextStyle(fontSize: 16, height: 1.6)),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}