class AppConstants {
  static const String homeSectionEndpoint = "/mock/famapp/feed/home_section/";
}

enum DesignType {
  hc1('HC1'),
  hc3('HC3'),
  hc5('HC5'),
  hc6('HC6'),
  hc9('HC9');

  final String value;
  const DesignType(this.value);

  static DesignType? fromString(String? value) {
    if (value == null) return null;
    try {
      return DesignType.values.firstWhere(
        (type) => type.value.toUpperCase() == value.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
