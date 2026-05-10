import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail.dart';
import '../services/meal_api_service.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  Future<void> _launchYoutube(String? url) async {
    if (url == null || url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Details')),
      body: FutureBuilder<MealDetail>(
        future: MealApiService().fetchMealDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final meal = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal.thumbnail, width: double.infinity, height: 250, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meal.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('${meal.area} | ${meal.category}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      const Divider(height: 32),
                      const Text('Instructions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text(meal.instructions, style: const TextStyle(fontSize: 16, height: 1.5)),
                      const SizedBox(height: 30),
                      if (meal.youtubeUrl != null)
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                            label: const Text('Watch Recipe on YouTube'),
                            onPressed: () => _launchYoutube(meal.youtubeUrl),
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                          ),
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}