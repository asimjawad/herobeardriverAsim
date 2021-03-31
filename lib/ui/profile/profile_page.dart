import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/profile/review_tile_wgt.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ProfilePage extends StatelessWidget {
  static const _heightHeader = 200.0;
  static const _sizeProfileBadge = 70.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildTripYearWgt(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.insetM,
                      ),
                      child: Text(Strings.reviews),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.all(Dimens.insetM / 2),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.insetM / 2),
              child: ReviewTileWgt(
                title: 'Title',
                subtitle: 'subtitle',
                rating: 3,
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: _heightHeader,
      color: colorScheme.primary,
      padding: EdgeInsets.all(Dimens.insetM),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.insetXs),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.keyboard_arrow_left),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Dimens.insetS,
                ),
                ClipOval(
                  child: Container(
                    height: _sizeProfileBadge,
                    width: _sizeProfileBadge,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: Dimens.insetM,
                ),
                Text('User Name'),
              ],
            ),
            Container(
              padding: EdgeInsets.all(Dimens.insetXs),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTripYearWgt(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.insetM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('X'),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(Strings.trips),
            ],
          ),
          Column(
            children: [
              Text('X'),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(Strings.trips),
            ],
          ),
        ],
      ),
    );
  }
}
