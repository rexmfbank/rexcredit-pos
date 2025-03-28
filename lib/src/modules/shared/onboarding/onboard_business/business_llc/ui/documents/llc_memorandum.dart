// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_upload_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LLC_Memorandum extends ConsumerWidget {
  const LLC_Memorandum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docState = ref.watch(llcDocProvider);
    return BusinessFileUploadWidget(
      titleText: BusinessFileEnum.MEMORANDUM_OF_ASSOCIATION.tag,
      subtitleText: docState.memorandumFile == null
          ? StringAssets.uploadDocInstructions
          : docState.memorandumFileName!,
      docStatus: docState.memorandum,
      onPressed: () => ref.read(llcDocProvider.notifier).getFileFromDevice(
          docType: BusinessFileEnum.MEMORANDUM_OF_ASSOCIATION),
      actionBtnText: StringAssets.uploadDocument,
    );
  }
}
