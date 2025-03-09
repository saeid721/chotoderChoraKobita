import 'package:flutter/material.dart';
import 'colors.dart';

const double cardHeight = 180.0;
const double imageWidth = 80.0;
const double imageHeight = 80.0;

class CategoryCardWidget extends StatelessWidget {
  final String? imagePath; // Make imagePath optional
  final String title;
  final VoidCallback onTap;

  const CategoryCardWidget({
    super.key,
    this.imagePath, // imagePath can be null
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shadowColor: ColorRes.borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          height: cardHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorRes.white,
            border: const Border(
              bottom: BorderSide(
                color: ColorRes.borderColor, // Define the color of the bottom border
                width: 1.0, // Set the thickness of the bottom border
              ),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: ColorRes.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
