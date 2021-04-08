import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_bear_driver/data/app_bloc.dart';
import 'package:hero_bear_driver/data/models/driver_reviews_model/driver_reviews_model.dart';
import 'package:hero_bear_driver/ui/profile/review_tile_wgt.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ProfilePage extends StatelessWidget {
  static const _heightHeader = 200.0;
  static const _sizeProfileBadge = 70.0;
  final _appBloc = Get.find<AppBloc>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: FutureBuilder<DriverReviewsModel>(
            future: _appBloc.getDriverReviews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final driverData = snapshot.data!;
                final reviews = driverData.data.reviews;
                var currentYear = DateTime.now().year;
                var driverCreatedYear = driverData.data.createdAt.year;

                var year = currentYear - driverCreatedYear;

                return NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(context, driverData),
                              _buildTripYearWgt(context, driverData, year),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.insetM,
                                ),
                                child: Text(
                                  Strings.reviews,
                                  style: textTheme.headline2,
                                ),
                              ),
                            ],
                ),
              ),
            ),
          ];
        },
                  body: ListView.builder(
                      padding: EdgeInsets.all(Dimens.insetM / 2),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(Dimens.insetM / 2),
                        child: ReviewTileWgt(
                          title: reviews[index].name,
                          subtitle: reviews[index].reviews,
                          rating: double.parse(reviews[index].rating).toInt(),
                          image: Image.network(
                              '${driverData.baseUrlProfile}${reviews[index].image}',
                              fit: BoxFit.fill),
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  static Widget _buildHeader(BuildContext context, DriverReviewsModel driver) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final buildCircleBtn = ({
      required IconData icData,
      required void Function() onTap,
    }) =>
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(Dimens.insetXs),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icData),
          ),
        );
    return Container(
      height: _heightHeader,
      color: colorScheme.primary,
      padding: EdgeInsets.all(Dimens.insetM),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCircleBtn(
              icData: Icons.keyboard_arrow_left,
              onTap: () => Navigator.pop(context),
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
                    child: Image.network(
                        '${driver.baseUrlProfile}${driver.data.image}'),
                  ),
                ),
                SizedBox(
                  height: Dimens.insetM,
                ),
                Text(
                  driver.data.name,
                  style: Styles.onPrimaryTextTheme.headline2,
                ),
              ],
            ),
            buildCircleBtn(
              icData: Icons.edit,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTripYearWgt(
      BuildContext context, DriverReviewsModel driver, dynamic years) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(Dimens.insetM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                driver.trips.toString(),
                style: textTheme.headline2,
              ),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(
                Strings.trips,
                style: textTheme.bodyText1,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                years.toString(),
                style: textTheme.headline2,
              ),
              SizedBox(
                height: Dimens.insetS,
              ),
              Text(
                Strings.years,
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
