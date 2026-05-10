import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/meal_category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';
import 'api_exception.dart';

class MealApiService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  final Duration _timeout = const Duration(seconds: 10); // Required for Section 4.3

  /// 1. Fetch all Categories (Home Screen)
  Future<List<MealCategory>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/categories.php'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> categoriesJson = data['categories'];
        return categoriesJson
            .map((json) => MealCategory.fromJson(json))
            .toList();
      } else {
        throw ApiException('Server error', response.statusCode);
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Error fetching categories: $e');
    }
  }

  /// 2. Fetch Meals by Category (Meal List Screen)
  Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/filter.php?c=$categoryName'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];

        if (mealsJson == null) return [];

        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load meals', response.statusCode);
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Error fetching meals: $e');
    }
  }

  /// 3. Fetch Full Meal Details (Detail Screen - Required for Track C)
  Future<MealDetail> fetchMealDetails(String mealId) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/lookup.php?i=$mealId'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? meals = data['meals'];

        if (meals != null && meals.isNotEmpty) {
          return MealDetail.fromJson(meals[0]);
        } else {
          throw ApiException('Meal not found');
        }
      } else {
        throw ApiException('Server error', response.statusCode);
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Error fetching meal details: $e');
    }
  }
}