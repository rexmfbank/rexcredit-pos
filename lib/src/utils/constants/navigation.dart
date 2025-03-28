import 'package:flutter/material.dart';

extension AppNavigation on BuildContext {
  Future<T?> pushSuper<T extends Object?>(Widget child) async {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  void popSuper<T extends Object?>([T? result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<T?> pushReplacementSuper<T extends Object?>(Widget child) async {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  Future<T?> pushAndPopAllSuper<T extends Object?>(Widget child) async {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      (route) => false,
    );
  }

  Future<T?> pushAndRemoveTillPredicateSuper<T extends Object?>(
    Widget child, {
    required RoutePredicate predicate,
  }) async {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      predicate,
    );
  }

  Future<T?> pushFullScreenDialogSuper<T extends Object?>(Widget child) async {
    return Navigator.of(this).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => child,
      ),
    );
  }
}
