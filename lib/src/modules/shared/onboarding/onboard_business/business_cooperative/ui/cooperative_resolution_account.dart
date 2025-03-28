import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_cooperative/provider/cooperative_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CooperativeResolutionAccount extends ConsumerWidget {
  const CooperativeResolutionAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(cooperativeDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.tag,
      subtitleText: docState.resAccountFile == null
          ? StringAssets.uploadDocInstructions
          : docState.resAccountFileName!,
      docStatus: docState.resAccount,
      onPressed: () => ref
          .read(cooperativeDocProvider.notifier)
          .getFileFromDevice(
              docType: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING),
      actionBtnText: StringAssets.selectDocument,
    );
  }
}
