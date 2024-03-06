enum GenderType {
  male,
  female,
  unknown,
}

extension GenderTypeExt on GenderType {
  static GenderType? fromCode(String? code) {
    if (code == GenderType.male.code) {
      return GenderType.male;
    } else if (code == GenderType.female.code) {
      return GenderType.female;
    } else if (code == GenderType.unknown.code) {
      return GenderType.unknown;
    }
    return null;
  }

  String? get code {
    switch (this) {
      case GenderType.male:
        return 'male';
      case GenderType.female:
        return 'female';
      case GenderType.unknown:
        return 'unknown';
    }
  }

  String get text {
    switch (this) {
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
      case GenderType.unknown:
        return 'Unknown';
    }
  }
}
