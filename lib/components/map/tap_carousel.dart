
import 'package:flutter/material.dart';

import './tap_card.dart';

class TapCarousel extends StatelessWidget {
  final List<TapCard> items;
  final CarouselController carouselController;
  final Function(int) onTap;

  const TapCarousel({super.key, required this.items, required this.carouselController, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250,
      ),
      child: CarouselView(
        onTap: (value) => onTap(value),
        controller: carouselController,
        scrollDirection: Axis.horizontal,
        itemExtent: MediaQuery.of(context).size.width - 32,
        shrinkExtent: 250,
        itemSnapping: true,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: item,
          );
        }).toList(),
      ),
    );
  }
}