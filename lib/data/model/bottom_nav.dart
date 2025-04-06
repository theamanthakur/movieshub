import '../../config/config.dart';

class BottomNavData {
  final String title;
  final Image image;

  BottomNavData({required this.title, required this.image});
}

List<BottomNavData> bottomNavItem = [
  BottomNavData(
    title: "Explore",
    image: Image(
      image: AssetImage(Assets.images.explore.path),
    ),
  ),
  BottomNavData(
    title: "Discover",
    image: Image(
      image: AssetImage(Assets.images.discover.path),
    ),
  ),
  BottomNavData(
    title: "Add",
    image: Image(
      image: AssetImage(Assets.images.add.path),
    ),
  ),
  BottomNavData(
    title: "Recent",
    image: Image(
      image: AssetImage(Assets.images.recent.path),
    ),
  ),
];
