import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/kyc/kyc_documents_list_view.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessKycDocuments extends ConsumerStatefulWidget {
  const BusinessKycDocuments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessKycDocumentsState();
}

class _BusinessKycDocumentsState extends ConsumerState<BusinessKycDocuments> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(kycNotifier.notifier).getKycDocInfo(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      //isLoading: ref.watch(kycNotifier).isLoading,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.businessDocumentText,
        subtitle: StringAssets.businessDocumentSubText,
      ),
      body: KycDocumentsListView(),
      /*body: Padding(
        padding: EdgeInsets.only(top: 20.ah),
        child: Builder(builder: (context) {
          if (ref.watch(kycNotifier).kycInfo.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: const EmptyInventoryScreen(
                lottieValue: LottieAsset.agreementAnimation,
                title: StringAssets.oopsSorry,
                subtitle: StringAssets.noDocumentsFound,
                showButtons: false,
              ),
            );
          }

          return ListView.builder(
            itemCount: ref.watch(kycNotifier).kycInfo.length,
            itemBuilder: (context, index) => RexListTile(
                leadingWidget: SvgPicture.asset(
                  AssetPath.docUploadIcon,
                  height: 30.ah,
                  width: 25.aw,
                  color: ref
                      .watch(kycNotifier.notifier)
                      .kycColor(ref.watch(kycNotifier).kycInfo[index].status!),
                ),
                title: ref.watch(kycNotifier).kycInfo[index].documentTitle ??
                    'N/A',
                subtitle: ref.watch(kycNotifier).kycInfo[index].documentText ??
                    '****',
                status:
                    ref.watch(kycNotifier).kycInfo[index].status!.jsonString,
                hasTrailingIcon: true,
                verifiedField: ref.watch(kycNotifier.notifier).kycVerifying(
                    ref.watch(kycNotifier).kycInfo[index].status!),
                tileColor: ref
                    .watch(kycNotifier.notifier)
                    .kycColor(ref.watch(kycNotifier).kycInfo[index].status!),
                onTap: () {
                  ref
                      .watch(kycNotifier.notifier)
                      .selectKyc(ref.watch(kycNotifier).kycInfo[index]);
                  context.pushSuper(
                    KycDocumentsUpload(
                      kycInfo: ref.watch(kycNotifier).kycInfo[index],
                    ),
                  );
                }),
          );
        }),
      ),*/
    );
  }
}
