import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/provider/proprietor_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ProprietorUtilityBill extends ConsumerWidget {
  const ProprietorUtilityBill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(proprietorDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.UTILITY_BILL.tag,
      subtitleText: docState.utilityBillFile == null
          ? StringAssets.uploadDocInstructions
          : docState.utilityBillFileName!,
      docStatus: docState.utilityBill,
      onPressed: () => ref
          .read(proprietorDocProvider.notifier)
          .getFileFromDevice(docType: BusinessFileEnum.UTILITY_BILL),
      actionBtnText: StringAssets.selectDocument,
    );
  }
}
