import 'package:flutter/material.dart';
import '../../data/models/reel_model.dart';

class ReelsViewModel extends ChangeNotifier {
  final List<ReelModel> reels = [
    ReelModel(
      username: 'benelli552x',
      imageUrl: 'https://picsum.photos/1080/1920?1',
      description: 'Adventure setup',
      likes: 673000,
      comments: 2929,
    ),
    ReelModel(
      username: 'qjmotor.kg',
      imageUrl: 'https://picsum.photos/1080/1920?2',
      description: 'New gear',
      likes: 186000,
      comments: 12400,
    ),
    ReelModel(
      username: 'motolife',
      imageUrl: 'https://picsum.photos/1080/1920?3',
      description: 'Road trip',
      likes: 98500,
      comments: 860,
    ),
  ];
}
