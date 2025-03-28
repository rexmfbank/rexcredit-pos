import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_partnership/provider/partnership_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PartnershipDeed extends ConsumerWidget {
  const PartnershipDeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(partnershipDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.PARTNERSHIP_DEED.tag,
      subtitleText: docState.deedFile == null
          ? StringAssets.uploadDocInstructions
          : docState.deedFileName!,
      docStatus: docState.deed,
      onPressed: () => ref
          .read(partnershipDocProvider.notifier)
          .getFileFromDevice(docType: BusinessFileEnum.PARTNERSHIP_DEED),
      actionBtnText: StringAssets.selectDocument,
    );
  }
}
