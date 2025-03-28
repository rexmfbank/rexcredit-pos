import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/kyc/kyc_documents_list_view.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AdditionalDocumentsScreen extends ConsumerStatefulWidget {
  const AdditionalDocumentsScreen({super.key});

  @override
  ConsumerState<AdditionalDocumentsScreen> createState() =>
      _AdditionalDocumentsScreenState();
}

class _AdditionalDocumentsScreenState
    extends ConsumerState<AdditionalDocumentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(kycNotifier.notifier).getKycDocInfo(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      //isLoading: ref.watch(kycNotifier).isLoading,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.addDocumentScreenTitle,
        subtitle: StringAssets.addDocumentScreenSubtitle,
      ),
      body: const KycDocumentsListView(),
    );
  }
}
