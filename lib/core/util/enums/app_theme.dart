enum AppTheme {
  light,
  dark;

  bool get isLight => this == AppTheme.light;
  bool get isDark => this == AppTheme.dark;
}
