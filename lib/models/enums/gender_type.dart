enum GenderType {
  male,
  female,
  other,
}

extension GenderTypeExtension on GenderType {
  static GenderType? fromString(String text) {
    final sampleText = text.toLowerCase();
    if (sampleText == "male" || sampleText == "nam") {
      return GenderType.male;
    } else if (sampleText == "female" || sampleText == "nữ") {
      return GenderType.female;
    } else if (sampleText == "other" || sampleText == "khác") {
      return GenderType.other;
    }
    return null;
  }

  String get vnText {
    switch (this) {
      case GenderType.male:
        return 'Nam';
      case GenderType.female:
        return 'Nữ';
      case GenderType.other:
        return 'Khác';
      default:
        return '';
    }
  }

  String get enText {
    switch (this) {
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
      case GenderType.other:
        return 'Other';
      default:
        return '';
    }
  }
}
