import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_partnership/provider/partnership_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PartnershipResAccount extends ConsumerWidget {
  const PartnershipResAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(partnershipDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.tag,
      subtitleText: docState.resAccountFile == null
          ? StringAssets.uploadDocInstructions
          : docState.resAccountFileName!,
      docStatus: docState.resAccount,
      onPressed: () => ref
          .read(partnershipDocProvider.notifier)
          .getFileFromDevice(
              docType: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING),
      actionBtnText: StringAssets.selectDocument,
    );
  }
}
