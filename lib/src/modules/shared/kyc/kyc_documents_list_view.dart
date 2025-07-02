import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/kyc/kyc_documents_upload.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class KycDocumentsListView extends ConsumerWidget {
  const KycDocumentsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kycNotif = ref.watch(kycNotifier.notifier);
    final aList = ref.watch(getKycDocListProvider);

    return aList.when(
      data: (docInfoList) {
        if (docInfoList == null) {
          return Text('no information');
        }
        return ListView.builder(
            itemCount: docInfoList.length,
            itemBuilder: (context, index) {
              return RexListTile(
                  leadingWidget: SvgPicture.asset(AssetPath.docUploadIcon,
                      height: 30.ah,
                      width: 25.aw,
                      color: kycNotif.kycColor2(docInfoList[index].status!)
                      // color: ref
                      //     .watch(kycNotifier.notifier)
                      //     .kycColor(ref.watch(kycNotifier).kycInfo[index].status!),
                      ),
                  // title:
                  //     ref.watch(kycNotifier).kycInfo[index].documentTitle ?? 'N/A',
                  // subtitle:
                  //     ref.watch(kycNotifier).kycInfo[index].documentText ?? '****',
                  // status: ref.watch(kycNotifier).kycInfo[index].status!.jsonString,
                  title: docInfoList[index].documentTitle ?? 'N/A',
                  subtitle: docInfoList[index].documentText ?? "****",
                  status: docInfoList[index].status!,
                  hasTrailingIcon: true,
                  // verifiedField: ref
                  //     .watch(kycNotifier.notifier)
                  //     .kycVerifying(ref.watch(kycNotifier).kycInfo[index].status!),
                  // tileColor: ref
                  //     .watch(kycNotifier.notifier)
                  //     .kycColor(ref.watch(kycNotifier).kycInfo[index].status!),
                  verifiedField:
                      kycNotif.kycVerifying2(docInfoList[index].status!),
                  tileColor: kycNotif.kycColor2(docInfoList[index].status!),
                  onTap: () {
                    ref
                        .watch(kycNotifier.notifier)
                        .selectKyc(ref.watch(kycNotifier).kycInfo[index]);
                    context.pushSuper(
                      KycDocumentsUpload(
                        kycInfo: ref.watch(kycNotifier).kycInfo[index],
                      ),
                    );
                  });
            });
      },
      error: (error, _) {
        return Center();
        // return Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16.aw),
        //   child: const EmptyInventoryScreen(
        //     lottieValue: LottieAsset.agreementAnimation,
        //     title: StringAssets.oopsSorry,
        //     subtitle: StringAssets.noDocumentsFound,
        //     showButtons: false,
        //   ),
        // );
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class KycDocInfoWidget extends ConsumerWidget {
  const KycDocInfoWidget({
    super.key,
    required this.kycDocInfo,
  });

  final KycDocInfo kycDocInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kycNotif = ref.watch(kycNotifier.notifier);
    return RexListTile(
        leadingWidget: SvgPicture.asset(
          AssetPath.docUploadIcon,
          height: 30.ah,
          width: 25.aw,
          color: kycNotif.kycColor2(kycDocInfo.status!),
        ),
        title: kycDocInfo.documentTitle ?? 'N/A',
        subtitle: kycDocInfo.documentText ?? "****",
        status: kycDocInfo.status!,
        hasTrailingIcon: true,
        verifiedField: kycNotif.kycVerifying2(kycDocInfo.status!),
        tileColor: kycNotif.kycColor2(kycDocInfo.status!),
        onTap: () {
          ref.watch(kycNotifier.notifier).selectKyc(kycDocInfo);
          context.pushSuper(KycDocumentsUpload(kycInfo: kycDocInfo));
        });
  }
}

/*class AdditionalDocumentsListView extends ConsumerWidget {
  const AdditionalDocumentsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
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
            status: ref.watch(kycNotifier).kycInfo[index].status!.jsonString,
            hasTrailingIcon: true,
            verifiedField: ref
                .watch(kycNotifier.notifier)
                .kycVerifying(ref.watch(kycNotifier).kycInfo[index].status!),
            tileColor: ref
                .watch(kycNotifier.notifier)
                .kycColor(ref.watch(kycNotifier).kycInfo[index].status!),
            onTap: () {
              ref
                  .watch(kycNotifier.notifier)
                  .selectKyc(ref.watch(kycNotifier).kycInfo[index]);
              context.pushSuper(
                UploadKycDocuments(
                  kycInfo: ref.watch(kycNotifier).kycInfo[index],
                ),
              );
            }),
      );
    });
  }
}*/
