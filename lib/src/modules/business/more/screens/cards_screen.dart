import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_empty.dart';
import 'package:rex_app/src/modules/business/more/screens/components/cards_tabbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class CardsScreen extends StatefulHookConsumerWidget {
  const CardsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardsScreenState();
}

class _CardsScreenState extends ConsumerState<CardsScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2, vsync: this);
    // final cards = ref.watch(cardCreatedProvider);
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Cards',
        subtitle: 'Apply for a card to meet your business needs',
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CardsTabBar(tabController: tabController),
            const SizedBox(height: 16),
            CardsEmpty(tabController: tabController),
            // CardsCreated(tabController: tabController),
          ],
        ),
      ),
    );
  }
}
