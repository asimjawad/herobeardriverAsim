import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ReviewTileWgt extends StatelessWidget {
  final String title;
  final String subtitle;
  final int rating;
  final Widget? image;

  static const _maxStarCount = 5;

  const ReviewTileWgt({
    required this.title,
    required this.subtitle,
    this.rating = 0,
    this.image,
    Key? key,
  })  : assert(rating >= 0 && rating < 6),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          width: 50,
          height: 50,
        ),
        SizedBox(
          width: Dimens.insetS,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.title),
            Text(this.subtitle),
            _buildStars(context),
          ],
        ),
      ],
    );
  }

  Widget _buildStars(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: List.generate(
          _maxStarCount,
          (index) => Icon(
                Icons.star,
                color: index < rating ? colorScheme.primary : Colors.grey,
              )),
    );
  }
}
