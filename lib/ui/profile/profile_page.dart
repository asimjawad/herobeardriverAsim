import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/profile/review_tile_wgt.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ReviewTileWgt(
      //       title: 'Title',
      //       subtitle: 'subtitle',
      //       rating: 3,
      //     ),
      //   ],
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(itemBuilder: (_, index) {
          return ReviewTileWgt(
            title: 'Title',
            subtitle: 'subtitle',
            rating: 3,
          );
        }),
      ),
    );
  }
}
