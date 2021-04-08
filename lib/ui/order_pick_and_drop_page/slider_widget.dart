import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class SliderWidget extends StatefulWidget {
  final ValueChanged<double>? valueChanged;
  final void Function() func;
  final BuildContext? context;

  SliderWidget({this.valueChanged,required this.func,this.context});

  @override
  SliderWidgetState createState() {
    return SliderWidgetState();
  }
}

class SliderWidgetState extends State<SliderWidget> {
  ValueNotifier<double> valueListener = ValueNotifier(.0);
  static const double _containerH = 50.0;
  final double _imageH = 40.0;

  @override
  void initState() {
    valueListener.addListener(notifyParent);
    super.initState();
  }

  void notifyParent() {
    if (widget.valueChanged != null) {
      widget.valueChanged!(valueListener.value);
    }
    if(valueListener.value == 1.0){
      // print('sayo nara');
      widget.func();
    }
    // print(valueListener.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.yellow400,
        borderRadius: BorderRadius.circular(Dimens.insetS),
      ),
      height: _containerH,
      // padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Builder(
        builder: (context) {
          final handle = GestureDetector(
            onHorizontalDragUpdate: (details) {
              valueListener.value = (valueListener.value +
                  details.delta.dx / (context.size!.width-50))
                  .clamp(.0, 1.0);
              // print(valueListener.value);
            },
            child: Image.asset(MyImgs.doubleArrow,height: _imageH,width: _imageH,color: Colors.white,),
          );

          return AnimatedBuilder(
            animation: valueListener,
            builder: (context, child) {
              return Align(
                alignment: Alignment(valueListener.value * 2 - 1, .5),
                child: child,
              );
            },
            child: handle,
          );
        },
      ),
    );
  }
}