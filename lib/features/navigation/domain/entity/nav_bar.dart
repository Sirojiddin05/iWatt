class NavBar {
  final int id;
  final String title;
  final String icon;
  final bool isImage;

  const NavBar({
    required this.title,
    required this.id,
    required this.icon,
    this.isImage = false,
  });
}
