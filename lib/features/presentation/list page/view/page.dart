
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/enums/list_item_type.dart';
import 'package:fun_ui5/core/widgets/common.dart';
import 'package:fun_ui5/features/presentation/list%20page/view/widgets.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation> _animations = [];

  late AnimationController _exitAnimationController;
  late Animation _exitAnimation;

  @override
  void initState() {
    
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    final animationsBreakPoints = [0.0, 0.5];

    for (int i = 0; i < animationsBreakPoints.length; i++) {
      _animations.add(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(
              animationsBreakPoints[i], animationsBreakPoints[i] + 0.5))));
    }

    _exitAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _exitAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _exitAnimationController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 200),
        () async => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    
    _exitAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedBuilder(
                animation: _exitAnimation,
                builder: (context, _) {
                  return Column(
                    children: [
                      kHeight(20.h),
                      Transform.translate(
                        offset: Offset(0.0, -50.h * _exitAnimation.value),
                        child: Opacity(
                          opacity: 1.0 - _exitAnimation.value,
                          child: Column(
                            children: [
                              AnimatedBuilder(
                                  animation: _animations[0],
                                  builder: (context, _) {
                                    return Transform.translate(
                                      offset: Offset(0.0,
                                          -20.h * (1 - _animations[0].value)),
                                      child: Opacity(
                                        opacity: _animations[0].value,
                                        child: kText(
                                          text: 'CHOOSE',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  }),
                              AnimatedBuilder(
                                  animation: _animations[1],
                                  builder: (context, _) {
                                    return Transform.translate(
                                      offset: Offset(0.0,
                                          20.h * (1 - _animations[1].value)),
                                      child: Opacity(
                                        opacity: _animations[1].value,
                                        child: kText(
                                          text: 'YOUR STYLE',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      kHeight(20.h),
                      Transform.translate(
                        offset: Offset(0.0, 100.h * _exitAnimation.value),
                        child: Opacity(
                          opacity: 1.0 - _exitAnimation.value,
                          child: Wrap(
                            children: [
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.stack,
                                delay: const Duration(milliseconds: 700),
                                imageHeight: 100.h,
                                title: 'APPAREL',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/shirts/1.png',
                                  'assets/shirts/2.png',
                                  'assets/shirts/3.png',
                                ],
                              ),

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.stack,
                                delay: const Duration(milliseconds: 900),
                                imageHeight: 100.h,
                                title: 'BOTTOM',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/shots/1.png',
                                  'assets/shots/2.png',
                                  'assets/shots/3.png',
                                ],
                              ),

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.que,
                                delay: const Duration(milliseconds: 1100),
                                imageHeight: 80.h,
                                title: 'BUCKET',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/hats/1.png',
                                  'assets/hats/2.png',
                                  'assets/hats/3.png',
                                ],
                              ),

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.que,
                                delay: const Duration(milliseconds: 1300),
                                imageHeight: 60.h,
                                title: 'BEANIE',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/caps/1.png',
                                  'assets/caps/2.png',
                                  'assets/caps/3.png',
                                ],
                              ),

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.que,
                                delay: const Duration(milliseconds: 1500),
                                imageHeight: 100.h,
                                title: 'SOCKS',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/socks/1.png',
                                  'assets/socks/2.png',
                                  'assets/socks/3.png',
                                ],
                              ),

                              ListPageWidgets.listItem(
                                animationController: _exitAnimationController,
                                size: size,
                                itemType: ListItemType.que,
                                delay: const Duration(milliseconds: 1800),
                                imageHeight: 70.h,
                                title: 'BAGS',
                                subtitle: 'Identity Acquired\nProduct (ODAMA)',
                                imageLinks: [
                                  'assets/bags/1.png',
                                  'assets/bags/2.png',
                                  'assets/bags/3.png',
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
