import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/more/screens/components/physical_card_tab_created.dart';
import 'package:rex_app/src/modules/business/more/screens/components/virtual_card_tab_created.dart';

class CardsCreated extends StatelessWidget {
  const CardsCreated({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TabBarView(
        controller: tabController,
        children: const [
          VirtualCardTabCreated(),
          PhysicalCardTabCreated(),
        ],
      ),
    );
  }
}
