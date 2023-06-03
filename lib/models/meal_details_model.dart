import 'dart:convert';
import 'package:http/http.dart' as http;

class MealDetails {
  List<Meals>? meals;

  MealDetails({this.meals});

  MealDetails.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meals({this.strMeal, this.strMealThumb, this.idMeal});

  Meals.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }

  static Future<List<Meals>> fetchMeals(String? id) async {
    List<Meals> results = [];
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$id'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> mealsJson = data['meals'];
      results = mealsJson.map((mealJson) => Meals.fromJson(mealJson)).toList();
    } else {
      throw Exception('Failed to load meals');
    }

    return results;
  }
}
