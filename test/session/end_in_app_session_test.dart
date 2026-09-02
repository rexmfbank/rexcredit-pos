import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/purchase/model/baseapp_purchase_res.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/session/end_in_app_session.dart';

void main() {
  group('inAppSessionProviders', () {
    test('includes card purchase state and excludes login', () {
      expect(inAppSessionProviders, contains(posCardPurchaseProvider));
      expect(inAppSessionProviders, isNot(contains(loginProvider)));
    });
  });

  group('posCardPurchaseProvider session reset', () {
    test('invalidating drops a completed purchase result', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(posCardPurchaseProvider.notifier)
          .updateStateAfterBaseAppReturns(
            const BaseAppPurchaseRes(
              statuscode: '00',
              message: 'Approved',
              amount: '1000',
            ),
          );

      expect(container.read(posCardPurchaseProvider).hasReturn, isTrue);
      expect(
        container.read(posCardPurchaseProvider).purchaseStatusCode,
        '00',
      );

      container.invalidate(posCardPurchaseProvider);

      expect(container.read(posCardPurchaseProvider).hasReturn, isFalse);
      expect(container.read(posCardPurchaseProvider).purchaseStatusCode, '');
    });
  });

  group('endInAppSession', () {
    testWidgets(
      'timeout from a pushed purchase screen then login lands on home',
      (tester) async {
        late WidgetRef sessionRef;
        final router = _sessionTestRouter(
          onRef: (ref) => sessionRef = ref,
        );

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pumpAndSettle();

        router.push(Routes.loginPurchaseOptionPath);
        await tester.pumpAndSettle();
        router.push(Routes.loginPurchaseScreenPath);
        await tester.pumpAndSettle();
        expect(find.text('PurchaseSuccess'), findsOneWidget);

        endInAppSession(ref: sessionRef, router: router);
        await tester.pumpAndSettle();

        expect(find.text('Login'), findsOneWidget);
        expect(find.text('PurchaseSuccess'), findsNothing);
        expect(router.canPop(), isFalse);

        router.go(Routes.loginHome);
        await tester.pumpAndSettle();

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('PurchaseSuccess'), findsNothing);
        expect(find.text('PurchaseOption'), findsNothing);
      },
    );

    testWidgets('timeout from home only goes to login', (tester) async {
      late WidgetRef sessionRef;
      final router = _sessionTestRouter(
        onRef: (ref) => sessionRef = ref,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);

      endInAppSession(ref: sessionRef, router: router);
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Home'), findsNothing);

      router.go(Routes.loginHome);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets(
      'a blocking PopScope cannot prevent logout from reaching login',
      (tester) async {
        late WidgetRef sessionRef;
        final router = _sessionTestRouter(
          onRef: (ref) => sessionRef = ref,
        );

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pumpAndSettle();

        router.push('/loginHome/blocked');
        await tester.pumpAndSettle();
        expect(find.text('Blocked'), findsOneWidget);

        endInAppSession(ref: sessionRef, router: router);
        await tester.pumpAndSettle();

        expect(find.text('Login'), findsOneWidget);
        expect(find.text('Blocked'), findsNothing);
      },
    );
  });
}

GoRouter _sessionTestRouter({void Function(WidgetRef ref)? onRef}) {
  final navKey = GlobalKey<NavigatorState>();
  return GoRouter(
    navigatorKey: navKey,
    initialLocation: Routes.loginHome,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const Text('Login'),
      ),
      GoRoute(
        path: Routes.loginHome,
        builder:
            (context, state) => Consumer(
              builder: (context, ref, _) {
                onRef?.call(ref);
                return const Text('Home');
              },
            ),
        routes: [
          GoRoute(
            parentNavigatorKey: navKey,
            path: Routes.loginPurchaseOption,
            builder: (context, state) => const Text('PurchaseOption'),
          ),
          GoRoute(
            parentNavigatorKey: navKey,
            path: Routes.loginPurchaseScreen,
            builder:
                (context, state) => Consumer(
                  builder: (context, ref, _) {
                    onRef?.call(ref);
                    return const Text('PurchaseSuccess');
                  },
                ),
          ),
          GoRoute(
            parentNavigatorKey: navKey,
            path: 'blocked',
            builder:
                (context, state) => const PopScope(
                  canPop: false,
                  child: Text('Blocked'),
                ),
          ),
        ],
      ),
    ],
  );
}
