
import 'package:flutter/material.dart';

Widget buildStatCard(String label, String value, IconData icon, MaterialColor color) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color[100],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color[600], size: 20),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color[600],
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}