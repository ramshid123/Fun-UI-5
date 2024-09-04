import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/enums/list_item_type.dart';
import 'package:fun_ui5/core/widgets/common.dart';

class ItemPageWidgets {
  static Widget itemContainer({
    required List<String> imageLinks,
    required String oldPrice,
    required String newPrice,
    required String subtitle,
    required ListItemType itemType,
  }) {
    return _ItemContainer(
      delay: const Duration(milliseconds: 500),
      imageLinks: imageLinks,
      oldprice: oldPrice,
      itemType: itemType,
      newPrice: newPrice,
      subtitle: subtitle,
    );
  }
}

class _ItemContainer extends StatefulWidget {
  final Duration delay;
  final String oldprice;
  final String newPrice;
  final List<String> imageLinks;
  final String subtitle;
  final ListItemType itemType;
  const _ItemContainer(
      {required this.delay,
      required this.oldprice,
      required this.newPrice,
      required this.imageLinks,
      required this.subtitle,
      required this.itemType});

  @override
  State<_ItemContainer> createState() => __ItemContainerState();
}

class __ItemContainerState extends State<_ItemContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation> _animations = [];

  @override
  void initState() {
    
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    final animationBreakPoints1 = [0.0, 0.2, 0.4, 0.5, 0.6];
    final animationBreakPoints2 = [0.2, 0.4, 0.7, 0.8, 0.9];

    for (int i = 0; i < animationBreakPoints1.length; i++) {
      _animations.add(
        Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(animationBreakPoints1[i], animationBreakPoints2[i],
                curve: Curves.easeInOut),
          ),
        ),
      );
    }

    Future.delayed(
        widget.delay, () async => await _animationController.forward());

    super.initState();
  }

  @override
  void dispose() {
    
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animations[0],
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0.0, 100.h * (1 - _animations[0].value)),
            child: Opacity(
              opacity: _animations[0].value,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    kHeight(50.h),
                    kWidth(double.infinity),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        for (int i = 0; i < 3; i++)
                          AnimatedBuilder(
                              animation: _animations[i + 2],
                              builder: (context, _) {
                                return Transform.translate(
                                  offset:
                                      widget.itemType == ListItemType.stack
                                          ? Offset.zero
                                          : Offset(
                                              i == 0
                                                  ? -30.w
                                                  : (i == 1 ? 0 : 30.w),
                                              0),
                                  child: Transform.scale(
                                    scale: (0.2 *
                                            (1 - _animations[i + 2].value)) +
                                        1,
                                    child: Transform.rotate(
                                      angle: widget.itemType ==
                                              ListItemType.que
                                          ? 0
                                          : i == 0
                                              ? math.pi * -0.05
                                              : (i == 1 ? math.pi * 0.05 : 0),
                                      child: Opacity(
                                        opacity: _animations[i + 2].value,
                                        child: Image.asset(
                                          
                                          widget.imageLinks[i],
                                          height: 300.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                      ],
                    ),
                    kHeight(30.h),
                    AnimatedBuilder(
                        animation: _animations[1],
                        builder: (context, _) {
                          return Opacity(
                            opacity: _animations[1].value,
                            child: Column(
                              children: [
                                kText(
                                  text: '\$${widget.oldprice}',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  textDecoration: TextDecoration.lineThrough,
                                  color: Colors.black45,
                                ),
                                kText(
                                  text: '\$${widget.newPrice}',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                kHeight(20.h),
                                kText(
                                  
                                  text: widget.subtitle,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          );
                        }),
                    kHeight(20.h),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
