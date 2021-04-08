import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class NoInternetWgt extends StatelessWidget {
  static const _sizeImg = 200.0;
  final void Function()? onTryAgain;

  const NoInternetWgt({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _sizeImg,
          height: _sizeImg,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(MyImgs.noInternet),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Strings.noInternetConnection,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 225,
          child: ElevatedButton(
            onPressed: onTryAgain,
            child: Text(Strings.tryAgain),
          ),
        ),
      ],
    );
  }
}
