import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _error = '';
  String _selectedCat = 'All';

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get selectedCat => _selectedCat;

  final List<String> categories = ['All', 'Beef', 'Chicken', 'Seafood', 'Dessert', 'Pasta'];
  final ApiService _api = ApiService();

  RecipeProvider() { search(''); }

  Future<void> search(String q) async {
    _isLoading = true; _error = ''; notifyListeners();
    try {
      if (_selectedCat == 'All' || q.isNotEmpty) {
        _recipes = await _api.fetchRecipes(q);
      } else {
        _recipes = await _api.filterByCategory(_selectedCat);
      }
      _saveCache();
    } catch (e) {
      if (!await _loadCache()) _error = 'Koneksi error. Coba lagi nanti ya!';
    } finally {
      _isLoading = false; notifyListeners();
    }
  }

  void updateCat(String c) { _selectedCat = c; search(''); }

  Future<void> _saveCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cache', json.encode(_recipes.map((e) => e.toJson()).toList()));
  }

  Future<bool> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('cache');
    if (data != null) {
      _recipes = (json.decode(data) as List).map((e) => Recipe.fromJson(e)).toList();
      return true;
    }
    return false;
  }
}