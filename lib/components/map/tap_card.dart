import 'package:city_keystones/models/keystones.dart';
import 'package:flutter/material.dart';

class TapCard extends StatelessWidget {
  final Keystone keystone;
  final Function(String id) onMoreInformation;

  const TapCard({
    super.key,
    required this.keystone,
    required this.onMoreInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(8.0),
      child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                height: 75,
                width: double.infinity,
                color: Colors.green,
              ),
              SizedBox(height: 8),
              Text(
                keystone.title,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                keystone.description,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 14),
              ),
              ],
                      ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(
            onPressed: () => onMoreInformation(keystone.id),
            label: const Text('More'),
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],),
    );
  }
}