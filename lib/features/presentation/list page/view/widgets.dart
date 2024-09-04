import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/enums/list_item_type.dart';
import 'package:fun_ui5/core/routes/route_names.dart';
import 'package:fun_ui5/core/widgets/common.dart';
import 'package:go_router/go_router.dart';

class ListPageWidgets {
  static Widget listItem({
    required Size size,
    required Duration delay,
    required ListItemType itemType,
    required List<String> imageLinks,
    required double imageHeight,
    required String title,
    required AnimationController animationController,
    required String subtitle,
  }) {
    return _ListItem(
      size: size,
      animationController: animationController,
      imageHeight: imageHeight,
      delay: delay,
      itemType: itemType,
      imageLinks: imageLinks,
      title: title,
      subtitle: subtitle,
    );
  }
}

class _ListItem extends StatefulWidget {
  final Size size;
  final Duration delay;
  final ListItemType itemType;
  final List<String> imageLinks;
  final String title;
  final String subtitle;
  final double imageHeight;
  final AnimationController animationController;

  const _ListItem(
      {required this.size,
      required this.delay,
      required this.itemType,
      required this.imageLinks,
      required this.imageHeight,
      required this.title,
      required this.subtitle,
      required this.animationController});

  @override
  State<_ListItem> createState() => __ListItemState();
}

class __ListItemState extends State<_ListItem>
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
              child: GestureDetector(
                onTap: () async {
                  await widget.animationController.forward();
                  if (context.mounted) {
                    context.goNamed(
                      RouteNames.detailsPage,
                      extra: {
                        'imageLinks': widget.imageLinks,
                        'newPrice': '18.99',
                        'oldPrice': '38.00',
                        'title': widget.title,
                        'subTitle': widget.subtitle,
                        'itemType': widget.itemType,
                      },
                    );
                  }
                  await Future.delayed(const Duration(milliseconds: 500));
                  await widget.animationController.reverse();
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  width: (widget.size.width / 2) - 40.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 228, 228),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
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
                                          child: SizedBox(
                                            height: 100.h,
                                            child: Image.asset(
                                              
                                              widget.imageLinks[i],
                                              
                                              height: widget.imageHeight,
                                              width: widget.imageHeight,
                                            ),
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
                              child: kText(
                                text: widget.title,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
