import 'package:flutter/material.dart';
import 'package:fun_ui5/core/routes/route_names.dart';
import 'package:fun_ui5/features/presentation/intro%20page/view/page.dart';
import 'package:fun_ui5/features/presentation/item%20page/view/page.dart';
import 'package:fun_ui5/features/presentation/list%20page/view/page.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final routes = GoRouter(
    initialLocation: RouteNames.introPage,
    routes: [
      GoRoute(
        path: RouteNames.introPage,
        builder: (context, state) => const IntroPage(),
        name: RouteNames.introPage,
      ),
      GoRoute(
        path: RouteNames.listPage,
        builder: (context, state) => const ListPage(),
        pageBuilder: (context, state) =>
            _customTransitionPage(child: const ListPage()),
        name: RouteNames.listPage,
        routes: [
          GoRoute(
            path: RouteNames.detailsPage, 
            builder: (context, state) => ItemPage(
              imageLinks: (state.extra as Map<String, dynamic>)['imageLinks'],
              newPrice: (state.extra as Map<String, dynamic>)['newPrice'],
              oldPrice: (state.extra as Map<String, dynamic>)['oldPrice'],
              title: (state.extra as Map<String, dynamic>)['title'],
              subTitle: (state.extra as Map<String, dynamic>)['subTitle'],
              itemType: (state.extra as Map<String, dynamic>)['itemType'],
            ),
            pageBuilder: (context, state) => _customTransitionPage(
              child: ItemPage(
                imageLinks: (state.extra as Map<String, dynamic>)['imageLinks'],
                newPrice: (state.extra as Map<String, dynamic>)['newPrice'],
                oldPrice: (state.extra as Map<String, dynamic>)['oldPrice'],
                title: (state.extra as Map<String, dynamic>)['title'],
                subTitle: (state.extra as Map<String, dynamic>)['subTitle'],
                itemType: (state.extra as Map<String, dynamic>)['itemType'],
              ),
            ),
            name: RouteNames.detailsPage, 
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage _customTransitionPage({
    required Widget child,
    
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
