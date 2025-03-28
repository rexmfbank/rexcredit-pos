import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/loading_indicator_overlay.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? appBarContent;
  final Widget? bottomSheet;
  final FloatingActionButton? actionButton;
  final FloatingActionButtonLocation? actionButtonLocation;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool centerTile;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final double? toolbarHeight;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool isLoading;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.appBarContent,
    this.bottomSheet,
    this.actionButton,
    this.actionButtonLocation,
    this.backgroundColor,
    this.padding,
    this.toolbarHeight,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.isLoading = false,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.centerTile = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoScaffold(
          body: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: backgroundColor ?? AppColors.rexWhite,
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              appBar: appBar ??
                  AppBar(
                    toolbarHeight:
                        toolbarHeight ?? AppConstants.size.toolBarHeight,
                    backgroundColor: backgroundColor ?? AppColors.rexWhite,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    centerTitle: centerTile,
                    title: appBarContent,
                  ),
              body: Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
                child: body,
              ),
              bottomSheet: Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
                child: bottomSheet,
              ),
              floatingActionButton: actionButton ?? floatingActionButton,
              floatingActionButtonLocation: actionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              persistentFooterButtons: persistentFooterButtons,
              //persistentFooterAlignment: persistentFooterAlignment,
              drawer: drawer,
              onDrawerChanged: onDrawerChanged,
              endDrawer: endDrawer,
              onEndDrawerChanged: onEndDrawerChanged,
              drawerScrimColor: drawerScrimColor,
              bottomNavigationBar: bottomNavigationBar,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
              primary: primary,
              drawerDragStartBehavior: drawerDragStartBehavior,
              drawerEdgeDragWidth: drawerEdgeDragWidth,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
              restorationId: restorationId,
            );
          }),
        ),
        LoadingIndicatorOverlay(isLoading: isLoading),
      ],
    );
  }
}
