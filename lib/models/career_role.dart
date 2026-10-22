enum CareerGlyph { code, data, design, intelligence, product }

class CareerRole {
  const CareerRole({
    required this.title,
    required this.summary,
    required this.matchScore,
    required this.glyph,
    required this.colorValue,
    required this.skills,
    required this.imageUrl,
    required this.salaryRange,
    required this.growth,
    required this.category,
    required this.learningPath,
  });

  final String title;
  final String summary;
  final int matchScore;
  final CareerGlyph glyph;
  final int colorValue;
  final List<String> skills;
  final String imageUrl;
  final String salaryRange;
  final String growth;
  final String category;
  final List<String> learningPath;

  String get id => title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
}

class CareerTrend {
  const CareerTrend({
    required this.name,
    required this.growth,
    required this.colorValue,
    required this.progress,
    required this.category,
    required this.icon,
  });

  final String name;
  final String growth;
  final int colorValue;
  final double progress;
  final String category;
  final CareerGlyph icon;
}
