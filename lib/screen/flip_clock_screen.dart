import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/widget/flip_bottom_top_animation_widget.dart';

class FlipClockScreen extends StatefulWidget {
  const FlipClockScreen({super.key});

  @override
  State<FlipClockScreen> createState() => _FlipClockScreenState();
}

class _FlipClockScreenState extends State<FlipClockScreen>
    with TickerProviderStateMixin {
  late AnimationController _secoundsAnimationController;
  late AnimationController _minutesAnimationController;
  late Animation _secoundsAnimation;
  late Animation _minutesAnimation;
  late Timer _timer;
  int _secounds = 0;
  int _minutes = 0;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        DateTime currentTime = DateTime.now();

        if (currentTime.second == 00) {
          setState(() {
            _minutes = currentTime.minute;
          });
          _minutesAnimationController.reset();
          _minutesAnimationController.forward();
        }

        setState(() {
          _secounds = currentTime.second;
        });
        _secoundsAnimationController.reset();
        _secoundsAnimationController.forward();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    DateTime currentTime = DateTime.now();

    _secounds = currentTime.second;
    _minutes = currentTime.minute;

    _secoundsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _secoundsAnimation = Tween<double>(end: math.pi, begin: math.pi * 2)
        .animate(_secoundsAnimationController);

    _minutesAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _minutesAnimation = Tween<double>(end: math.pi, begin: math.pi * 2)
        .animate(_minutesAnimationController);

    startTimer();

    _secoundsAnimationController.addListener(() {
      setState(() {});
    });

    _minutesAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 50, right: 50, left: 50, bottom: 50),
        color: const Color(0xff151515),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  FlipBottomTopAnimationWidget(
                    animation: _minutesAnimation,
                    value: _minutes.toString(),
                  ),
                  Positioned(
                    top: 5,
                    left: 10,
                    child: Container(
                      decoration:  BoxDecoration(
                        color: const Color(0xffA91D3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'PM',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xffEEEEEE),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 8,
              color: Colors.transparent,
            ),
            Expanded(
              flex: 2,
              child: FlipBottomTopAnimationWidget(
                    animation: _secoundsAnimation,
                    value: _secounds.toString(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
