class SearchService {
  /// В реальном проекте: запрос на backend / Algolia / Firestore / Elastic и т.д.
  /// Сейчас: отдаём сетку картинок.
  Future<List<String>> fetchImageUrls({required String query}) async {
    await Future.delayed(const Duration(milliseconds: 250));

    // Чтобы результаты менялись в зависимости от query — чуть “солим” random.
    final salt = query.trim().isEmpty ? 0 : query.trim().hashCode.abs() % 1000;

    return List.generate(
      36,
          (i) => 'https://picsum.photos/600/600?random=${salt + i + 100}',
    );
  }
}
