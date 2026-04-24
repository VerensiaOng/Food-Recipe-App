import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] != null 
          ? (data['meals'] as List).map((e) => Recipe.fromJson(e)).toList() 
          : [];
    }
    throw Exception('Gagal memuat data');
  }

  Future<List<Recipe>> filterByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] != null 
          ? (data['meals'] as List).map((e) => Recipe.fromJson(e)).toList() 
          : [];
    }
    throw Exception('Gagal memuat kategori');
  }

  Future<Recipe> fetchDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data['meals'][0]);
    }
    throw Exception('Gagal memuat detail');
  }
}