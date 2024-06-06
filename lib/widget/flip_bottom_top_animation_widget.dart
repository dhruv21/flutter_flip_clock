import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlipBottomTopAnimationWidget extends StatelessWidget {
  const FlipBottomTopAnimationWidget({
    super.key,
    required this.animation,
    required this.value,
  });

  final Animation animation;
  final String value;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight / 2.2,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Color(0xffA91D3A),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: -5,
                        child: Text(
                          value.padLeft(2, "0"),
                          style: const TextStyle(
                            fontSize: 300,
                            color: Color(0xffEEEEEE),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 3,
                  color: Colors.transparent,
                ),
                Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight / 2.2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Color(0xffA91D3A),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: -27,
                            child: Text(
                              value.toString().padLeft(2, "0"),
                              style: const TextStyle(
                                fontSize: 300,
                                color: Color(0xffEEEEEE),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: animation,
                      child: Container(
                        height: constraints.maxHeight / 2,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: const Color(0xffA91D3A),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            animation.value > 4.71
                                ? Positioned(
                                    bottom: -10,
                                    child: Text(
                                      value.toString().padLeft(2, "0"),
                                      style: const TextStyle(
                                        fontSize: 300,
                                        color: Color(0xffEEEEEE),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 185,
                                    child: Transform(
                                      transform: Matrix4.rotationX(math.pi),
                                      child: Text(
                                        value.toString().padLeft(2, "0"),
                                        style: const TextStyle(
                                          fontSize: 300,
                                          color: Color(0xffEEEEEE),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      builder: (context, child) => Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(animation.value),
                        child: child,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              top: constraints.maxHeight / 2.2,
              child: Container(
                height: 3,
                width: constraints.maxWidth + 25,
                color: const Color(0xff151515),
              ),
            )
          ],
        );
      },
    );
  }
}
