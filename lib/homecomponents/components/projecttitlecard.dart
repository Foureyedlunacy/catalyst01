import 'package:flutter/material.dart';

class Projecttitlecard extends StatelessWidget {
  const Projecttitlecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
  color: Colors.transparent, // Keeps container background visible
  child: InkWell(
    borderRadius: BorderRadius.circular(3), // Matches Container radius
    onTap: () {
      Navigator.pushNamed(context, '/Project');
    },
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 245, 232),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 66, 66, 66),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Section (Text & Progress Bar)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Project Type: Solo",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Project Title",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Add here about the projects in this info tab. It summarizes the project into small lines.",
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 12,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Right Section (Tag & Edit Button)
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF8AD5C), width: 3),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 229, 196),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: const Text(
                  "Public",
                  style: TextStyle(
                    color: Color(0xFFF8AD5C),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  // Navigate to /Project edit screen specifically
                  Navigator.pushNamed(context, '/Project');
                },
                icon: const Icon(
                  Icons.edit_document,
                  size: 40,
                  color: Color(0xFF325453),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
  }
}

