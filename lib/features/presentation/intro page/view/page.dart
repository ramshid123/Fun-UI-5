import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/constants/palette.dart';
import 'package:fun_ui5/core/routes/route_names.dart';
import 'package:fun_ui5/core/shared/functions/negative_color.dart';
import 'package:fun_ui5/core/widgets/common.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  ValueNotifier<double> swipeDistance = ValueNotifier(0.0);

  late AnimationController _entryAnimationController;
  late Animation _entryAnimation;

  late AnimationController _shimmerAnimationController;
  late Animation _shimmerAnimation;
  late Animation _circleMovementAnimation;

  late AnimationController _slideAnimationController;
  late Animation _slideAnimation;
  late Animation _containerColorAnimation;
  late Animation _circleColorAnimation;
  late Animation _textAnimation;

  late AnimationController _exitAnimationController;
  final List<Animation> _exitAnimation = [];

  bool isAnimControllerDismissed = false;

  @override
  void initState() {
    _entryAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _entryAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _entryAnimationController, curve: Curves.easeInOut));

    _shimmerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _shimmerAnimation = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(
        parent: _shimmerAnimationController, curve: Curves.easeInOut));

    _circleMovementAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -1.0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: -1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -1.0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
        parent: _shimmerAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutSine)));

    _slideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _slideAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _slideAnimationController, curve: Curves.easeInOut));

    _containerColorAnimation =
        ColorTween(begin: Colors.orange, end: Colors.white).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    _circleColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.black).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    _textAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    _exitAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _exitAnimation.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _exitAnimationController,
          curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
        ),
      ),
    );
    _exitAnimation.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _exitAnimationController,
          curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () async {
      await _entryAnimationController.forward();
      while (true) {
        if (swipeDistance.value == 0.0 && !isAnimControllerDismissed) {
          _shimmerAnimationController.reset();
          await _shimmerAnimationController.forward();
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    _shimmerAnimationController.dispose();
    _slideAnimationController.dispose();
    _exitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
          animation: _entryAnimation,
          builder: (context, _) {
            return Transform.translate(
              offset: Offset(0.0, 100.h * (1 - _entryAnimation.value)),
              child: Opacity(
                opacity: _entryAnimation.value,
                child: Stack(
                  
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Transform.scale(
                                scale: 4,
                                child: AnimatedBuilder(
                                    animation: _slideAnimation,
                                    builder: (context, _) {
                                      return Transform.translate(
                                        offset: Offset(
                                            i == 1
                                                ? (-25.h +
                                                    (100.h *
                                                        _slideAnimation.value))
                                                : -100.h *
                                                    _slideAnimation.value,
                                            0),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 40.h),
                                          child: Opacity(
                                            opacity:
                                                1.0 - _slideAnimation.value,
                                            child: kText(
                                              text: 'ORBALZ',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                              color: Colors.white
                                                  .withOpacity(0.15),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(1),
                                offset: const Offset(0, 0),
                                blurRadius: 300,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(1),
                                offset: const Offset(0, 0),
                                blurRadius: 300,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: AnimatedBuilder(
                          animation: _slideAnimation,
                          builder: (context, _) {
                            return Column(
                              children: [
                                kHeight(20.h),
                                Opacity(
                                  opacity: 1.0 - _slideAnimation.value,
                                  child: Column(
                                    children: [
                                      kText(
                                        text: 'Orbalz',
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      kText(
                                        text: 'Clothing store app',
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Transform.translate(
                                    offset: Offset(
                                        -50.w +
                                            (-100.w * _slideAnimation.value),
                                        0),
                                    child: Opacity(
                                      opacity: 1.0 - _slideAnimation.value,
                                      child: Transform.rotate(
                                        angle: math.pi / 10,
                                        child: Image.asset(
                                          'assets/hats/3.png',
                                          height: 120.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Transform.translate(
                                  offset: Offset(
                                      50.w + (100.w * _slideAnimation.value),
                                      0),
                                  child: Opacity(
                                    opacity: 1.0 - _slideAnimation.value,
                                    child: Transform.rotate(
                                      angle: -math.pi / 10,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          'assets/shots/2.png',
                                          height: 150.h,
                                          
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Transform.translate(
                                  offset: Offset(
                                      -50.w + (-100.w * _slideAnimation.value),
                                      0),
                                  child: Opacity(
                                    opacity: 1.0 - _slideAnimation.value,
                                    child: Transform.rotate(
                                      angle: math.pi / 10,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Transform.scale(
                                          scale: 1.7,
                                          child: Image.asset(
                                            'assets/shirts/1.png',
                                            height: 200.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.h),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return AnimatedBuilder(
                            animation: _containerColorAnimation,
                            builder: (context, _) {
                              return AnimatedBuilder(
                                  animation: _exitAnimation[1],
                                  builder: (context, _) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Transform.scale(
                                        scaleX:
                                            (1.5 * _exitAnimation[1].value) + 1,
                                        scaleY:
                                            (20.0 * _exitAnimation[1].value) +
                                                1,
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.r, vertical: 10.r),
                                          width: double.infinity,
                                          height: 80.r,
                                          decoration: BoxDecoration(
                                            color:
                                                _containerColorAnimation.value,
                                            borderRadius: BorderRadius.circular(
                                                ((1 - _exitAnimation[0].value) *
                                                        100.r) +
                                                    10.r),
                                          ),
                                          child: Stack(
                                            children: [
                                              AnimatedBuilder(
                                                  animation: _shimmerAnimation,
                                                  builder: (context, _) {
                                                    return Transform.translate(
                                                      offset: Offset(
                                                          size.width *
                                                              _shimmerAnimation
                                                                  .value,
                                                          0.0),
                                                      child: Transform.scale(
                                                        scale: 2,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            for (int i = 0;
                                                                i < 2;
                                                                i++)
                                                              Transform.rotate(
                                                                angle:
                                                                    -math.pi *
                                                                        0.15,
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.r),
                                                                  height: 60.r,
                                                                  width: 10.r,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .white,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            14,
                                                                        spreadRadius:
                                                                            1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              AnimatedBuilder(
                                                  animation: _exitAnimation[0],
                                                  builder: (context, _) {
                                                    return AnimatedBuilder(
                                                        animation:
                                                            _textAnimation,
                                                        builder: (context, _) {
                                                          return Opacity(
                                                            opacity: 1.0 -
                                                                _exitAnimation[
                                                                        0]
                                                                    .value,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Opacity(
                                                                    opacity: (1 -
                                                                            _textAnimation.value)
                                                                        .toDouble(),
                                                                    child:
                                                                        kText(
                                                                      text:
                                                                          'Get Started',
                                                                      color: ColorConstants
                                                                          .textWhiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          22,
                                                                    ),
                                                                  ),
                                                                  Opacity(
                                                                    opacity:
                                                                        _textAnimation
                                                                            .value,
                                                                    child:
                                                                        kText(
                                                                      text:
                                                                          'Welcome',
                                                                      color: ColorConstants
                                                                          .textBlackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          22,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  }),
                                              AnimatedBuilder(
                                                  animation: _slideAnimation,
                                                  builder: (context, _) {
                                                    return GestureDetector(
                                                      
                                                      
                                                      
                                                      onHorizontalDragUpdate:
                                                          (details) =>
                                                              _onDragUpdate(
                                                                  details
                                                                      .delta.dx,
                                                                  constraints
                                                                          .maxWidth -
                                                                      80.r),
                                                      onHorizontalDragEnd:
                                                          (details) => _onDragEnd(
                                                              constraints
                                                                      .maxWidth -
                                                                  80.r),
                                                      child:
                                                          Transform.translate(
                                                        offset: Offset(
                                                            (constraints.maxWidth -
                                                                    80.r) *
                                                                _slideAnimation
                                                                    .value,
                                                            0.0),
                                                        child: AnimatedBuilder(
                                                            animation:
                                                                _exitAnimation[
                                                                    0],
                                                            builder:
                                                                (context, _) {
                                                              return Opacity(
                                                                opacity: 1.0 -
                                                                    _exitAnimation[
                                                                            0]
                                                                        .value,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        30.r,
                                                                    backgroundColor:
                                                                        _circleColorAnimation
                                                                            .value,
                                                                    child: AnimatedBuilder(
                                                                        animation: _circleMovementAnimation,
                                                                        builder: (context, _) {
                                                                          return Transform
                                                                              .translate(
                                                                            offset:
                                                                                Offset(_circleMovementAnimation.value * 5.h, 0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/icons/drag.png',
                                                                              height: 30.r,
                                                                              color: invertColor(_circleColorAnimation.value),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            });
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onDragUpdate(double x, double maxWidth) {
    var newValue = swipeDistance.value + x;
    if (newValue <= 0.0) {
      swipeDistance.value = 0.0;
      _slideAnimationController.value = 0.0;
    } else if (newValue >= maxWidth) {
      swipeDistance.value = maxWidth;
      _slideAnimationController.value = 1.0;
    } else {
      swipeDistance.value = newValue;
      _slideAnimationController.value = newValue / maxWidth;
    }
  }

  void _onDragEnd(double maxWidth) async {
    var newValue = swipeDistance.value;

    if (newValue / maxWidth >= 0.7) {
      await _slideAnimationController.animateTo(1.0);
      swipeDistance.value = maxWidth;
    } else {
      await _slideAnimationController.animateTo(0.0);
      swipeDistance.value = 0.0;
    }

    if (_slideAnimationController.value == 1.0) {
      isAnimControllerDismissed = true;
      await _exitAnimationController.forward();
      if (mounted) {
        context.goNamed(RouteNames.listPage);
      }
    }
  }
}
