
import '../../config/config.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;

  const StarRating({super.key, required this.rating, required this.starSize});

  double _roundToNearestHalf(double value) {
    return (value * 2).round() / 2.0;
  }

  @override
  Widget build(BuildContext context) {
    double roundedRating = _roundToNearestHalf(rating);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.grayBorder)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          if (index + 1 <= roundedRating) {
            return Icon(Icons.star, color: Colors.amber, size: starSize);
          } else if (index + 0.5 == roundedRating) {
            return Icon(Icons.star_half, color: Colors.amber, size: starSize);
          } else {
            return Icon(Icons.star_border, color: Colors.amber, size: starSize);
          }
        }),
      ),
    );
  }
}