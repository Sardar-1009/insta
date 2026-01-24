import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;
  final bool hasRing;

  const Avatar({
    super.key,
    required this.url,
    this.size = 36,
    this.hasRing = false,
  });

  @override
  Widget build(BuildContext context) {
    final image = ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: size,
          height: size,
          color: Colors.white10,
        ),
        errorWidget: (_, __, ___) => Container(
          width: size,
          height: size,
          color: Colors.white10,
          child: const Icon(Icons.person, color: Colors.white54),
        ),
      ),
    );

    if (!hasRing) return image;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.pinkAccent),
      ),
      child: image,
    );
  }
}
