import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchGrid extends StatelessWidget {
  final List<String> images;
  final void Function(String url)? onTap;

  const SearchGrid({
    super.key,
    required this.images,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(child: Text('No results'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: images.length,
      itemBuilder: (_, i) {
        final url = images[i];
        return InkWell(
          onTap: onTap == null ? null : () => onTap!(url),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.white10),
            errorWidget: (_, __, ___) => Container(
              color: Colors.white10,
              child: const Icon(Icons.broken_image, color: Colors.white54),
            ),
          ),
        );
      },
    );
  }
}
