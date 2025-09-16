import 'package:flutter/material.dart';

class RiderInfoCard extends StatelessWidget {
  final String riderName;
  final double distanceInMeters;

  const RiderInfoCard({
    super.key,
    required this.riderName,
    required this.distanceInMeters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
             backgroundImage: NetworkImage('https://img.freepik.com/free-photo/food-delivery-boy-delivering-food-scooter_1303-27695.jpg?semt=ais_incoming&w=740&q=80'),
            
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                riderName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${distanceInMeters.toStringAsFixed(0)} meters away',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
