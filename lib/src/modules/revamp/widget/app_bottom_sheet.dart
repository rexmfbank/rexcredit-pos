import 'dart:ui';

import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<dynamic> showBottomsheet(
    BuildContext context, {
    required Widget widget,
    bool isDismissible = true,
    bool useRootNavigator = true,
    bool enableDrag = true,
  }) async {
    var res = await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        barrierColor: Colors.black.withOpacity(0.2),
        enableDrag: enableDrag,
        isScrollControlled: true,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: widget);
        });

    return res;
  }

  static Future<dynamic> animatedBottomDialog(BuildContext context,
      {required Widget widget,
      bool barrierDismissible = true,
      bool canPop = true,
      bool enableDrag = true}) async {
    var res = await showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return PopScope(
          canPop: canPop,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, -0.1)).animate(anim1),
          child: child,
        );
      },
    );

    return res;
  }

  static Future<dynamic> showDraggableBottomsheet(BuildContext context,
      {required Widget widget,
      bool isDismissible = true,
      double initialChildSize = 0.80,
      double maxChildSize = 0.80,
      double minChildSize = 0.80,
      bool enableDrag = true,
      bool useRootNavigator = true}) async {
    var res = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        enableDrag: enableDrag,
        isScrollControlled: true,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: DraggableScrollableSheet(
                initialChildSize: initialChildSize,
                maxChildSize: maxChildSize,
                minChildSize: minChildSize,
                expand: false,
                builder: (context, controller) {
                  return widget;
                }),
          );
        });
    return res;
  }
}

class AppPopupMenu {
  static Future<T?> showPopupMenu<T>(
    BuildContext context,
    GlobalKey<State> key, {
    required List<PopupMenuEntry<T>> items,
  }) async {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return await showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + renderBox.size.height,
          offset.dx + renderBox.size.width,
          offset.dy + 2 * renderBox.size.height),
      items: items,
    );
  }

  static Future<dynamic> showcupertinoPopMenu(
    BuildContext context,
    GlobalKey<State> key, {
    required List<PullDownMenuEntry<dynamic>> items,
  }) async {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    // return await showPullDownMenu(
    //   context: context,
    //   items: items,
    //   scrollController: ScrollController(),
    //   position: Rect.fromLTRB(
    //       offset.dy,
    //       offset.dy + renderBox.size.height,
    //       offset.dx + renderBox.size.width,
    //       offset.dy + 0.8 * renderBox.size.height),
    // );
  }
}

/// Used to limit types of children passed to [PullDownButton.itemBuilder].
@immutable
abstract class PullDownMenuEntry<T> extends Widget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const PullDownMenuEntry({super.key});

  bool represents(T? value);
}
