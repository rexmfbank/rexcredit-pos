import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/more/screens/components/physical_card_tab_empty.dart';
import 'package:rex_app/src/modules/business/more/screens/components/virtual_card_tab_empty.dart';

class CardsEmpty extends StatelessWidget {
  const CardsEmpty({
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
          VirtualCardTabEmpty(),
          PhysicalCardTabEmpty(),
        ],
      ),
    );
  }
}
