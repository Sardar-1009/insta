class ReelsService {
  /// Вертикальная лента изображений (без видео)
  Future<List<String>> fetchReelsImages() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.generate(
      20,
          (i) => 'https://picsum.photos/900/1600?random=${i + 500}',
    );
  }
}
