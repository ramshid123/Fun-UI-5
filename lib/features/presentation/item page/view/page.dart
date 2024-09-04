import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/enums/list_item_type.dart';
import 'package:fun_ui5/core/widgets/common.dart';
import 'package:fun_ui5/features/presentation/item%20page/view/widgets.dart';
import 'package:go_router/go_router.dart';

class ItemPage extends StatefulWidget {
  final List<String> imageLinks;
  final String title;
  final String subTitle;
  final String oldPrice;
  final String newPrice;
  final ListItemType itemType;
  const ItemPage(
      {super.key,
      required this.imageLinks,
      required this.title,
      required this.subTitle,
      required this.oldPrice,
      required this.newPrice,
      required this.itemType});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryAnimationController;
  final List<Animation> _entryAnimations = [];

  @override
  void initState() {
    
    _entryAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    final breakPoints1 = [0.0, 0.4, 0.6];
    final breakPoints2 = [0.4, 0.6, 1.0];

    for (int i = 0; i < breakPoints1.length; i++) {
      _entryAnimations.add(
        Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _entryAnimationController,
            curve: Interval(breakPoints1[i], breakPoints2[i],
                curve: Curves.easeInOut),
          ),
        ),
      );
    }

    Future.delayed(const Duration(milliseconds: 200),
        () async => await _entryAnimationController.forward());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedBuilder(
                animation: _entryAnimations[0],
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0.0,
                        (size.height / 2) * (1 - _entryAnimations[0].value)),
                    child: Transform.translate(
                      offset: Offset(0.0, size.height * 0.15),
                      child: Transform.scale(
                        scaleX: 1.05,
                        child: Container(
                          height: size.height / 2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Column(
              children: [
                kHeight(10.h),
                AnimatedBuilder(
                    animation: _entryAnimations[1],
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Transform.translate(
                            offset: Offset(
                                -50.w * (1 - _entryAnimations[1].value), 0.0),
                            child: Opacity(
                              opacity: _entryAnimations[1].value,
                              child: GestureDetector(
                                onTap: () => context.pop(),
                                child: Container(
                                  padding: EdgeInsets.all(5.r),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.navigate_before,
                                    color: Colors.white,
                                    size: 40.r,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(
                                0.0, -50.0.h * (1 - _entryAnimations[1].value)),
                            child: Opacity(
                              opacity: _entryAnimations[1].value,
                              child: kText(
                                text: 'OBARAL\n${widget.title}',
                                fontSize: 25,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Transform.translate(
                                                        offset: Offset(
                                50.w * (1 - _entryAnimations[1].value), 0.0),

                            child: Opacity(
                              opacity: _entryAnimations[1].value,
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 30.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 20.h,
                  width: double.infinity,
                ),
                ItemPageWidgets.itemContainer(
                    imageLinks: widget.imageLinks,
                    oldPrice: widget.oldPrice,
                    newPrice: widget.newPrice,
                    itemType: widget.itemType,
                    subtitle: widget.subTitle),
                const Spacer(),
                AnimatedBuilder(
                    animation: _entryAnimations[2],
                    builder: (context, _) {
                      return Transform.translate(
                        offset:
                            Offset(0.0, 50.h * (1 - _entryAnimations[2].value)),
                        child: Opacity(
                          opacity: _entryAnimations[2].value,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: 35.r,
                                ),
                                kWidth(20.w),
                                Icon(
                                  Icons.shopping_basket_outlined,
                                  size: 35.r,
                                ),
                                kWidth(20.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 35.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
