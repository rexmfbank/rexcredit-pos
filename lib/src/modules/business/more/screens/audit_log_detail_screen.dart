import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/more/screens/components/audit_log_detail_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class AuditLogDetailScreen extends HookConsumerWidget {
  const AuditLogDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: "Joseph Yobo's Log",
        subtitle: 'See below user action',
        hasActionButton: false,
      ),
      body: AuditLogDetailCard(
        activity: 'Made payment of 50,000 with your Rex virtual card',
        ipAddress: '207.234.87:32',
        dateTime: 'Feb, 22 2023 at 07:15 pm',
      ),
    );
  }
}
