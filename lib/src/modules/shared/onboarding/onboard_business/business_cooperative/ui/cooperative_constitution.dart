import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_cooperative/provider/cooperative_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CooperativeConstitution extends ConsumerWidget {
  const CooperativeConstitution({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(cooperativeDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.COPY_OF_CONSTITUTION.tag,
      subtitleText: docState.constitutionFile == null
          ? StringAssets.uploadDocInstructions
          : docState.constitutionFileName!,
      docStatus: docState.constitution,
      onPressed: () => ref
          .read(cooperativeDocProvider.notifier)
          .getFileFromDevice(docType: BusinessFileEnum.COPY_OF_CONSTITUTION),
      actionBtnText: StringAssets.selectDocument,
    );
  }
}
