import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hero_bear_driver/ui/values/values.dart';

class ProgressTimerWidget extends StatefulWidget {
  @override
  _ProgressTimerWidgetState createState() => _ProgressTimerWidgetState();
}
/*Widget build(BuildContext context) {

  return  Scaffold(
      appBar: AppBar(title: Text("Timer test")),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startTimer();
            },
            child: Text("start"),
          ),
          Text("$_start")
        ],
      ));
}*/
class _ProgressTimerWidgetState extends State<ProgressTimerWidget> {

  Timer? _timer;
  int _start = 0;
  final TWO_PI = 3.14 * 2;
  final double size = 50;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer =  Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start >= 60) {
            timer.cancel();
          } else {
            _start = _start + 1;
          }
        }));
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: TweenAnimationBuilder(
        tween: Tween(begin:0.0,end: 1.0),
        duration: Duration(seconds: 60),
        builder: (context,value,child){
          return Container(
            width: size,
            height: size,
            // color: MyColors.yellow400,
            child: Stack(
              children:[
                ShaderMask(
                  shaderCallback: (rect){
                    return SweepGradient(
                      startAngle: 0,
                      endAngle: TWO_PI,
                      stops: [double.parse(value.toString()),double.parse(value.toString())],
                      center: Alignment.center,
                      colors: [
                        MyColors.yellow400, Colors.grey.withAlpha(55)],
                    ).createShader(rect);
                  },
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: size-6,
                    width: size-6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('$_start')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
