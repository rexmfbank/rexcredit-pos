import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/get_security_question_provider.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class UpdateAccountScreen extends ConsumerStatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends ConsumerState<UpdateAccountScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(kycNotifier.notifier).getKycDocInfo(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verifiedKin = ref.watch(verifiedNextOfKinProvider);
    final verifiedBvn = true || ref.watch(verifiedBvnProvider);
    final verifiedQuestion = ref.watch(verifiedSecurityQuestionProvider);
    final verifiedDocument = ref.watch(verifiedDocumentProvider);
    //

    return Scaffold(
      appBar: CustomAppBar(
        title: StringAssets.updateTitle,
        subtitle: StringAssets.updateSubtitle,
      ),
      body: ListView(
        children: [
          RexListTile(
            title: StringAssets.bvnTitle,
            subtitle: StringAssets.bvnSubtitle,
            hasTrailingIcon: true,
            verifiedField: verifiedBvn,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.enterBvn}",
              );
            },
          ),
          Visibility(
            visible: true,
            child: RexListTile(
              title: StringAssets.documentTitle,
              subtitle: StringAssets.documentsSubtitle,
              hasTrailingIcon: true,
              verifiedField: false,
              onTap: () {
                context.push(
                  "${Routes.dashboardMore}/${Routes.additionalDocuments}",
                );
              },
            ),
          ),
          RexListTile(
            title: StringAssets.kinTitle,
            subtitle: StringAssets.kinSubtitle,
            hasTrailingIcon: true,
            verifiedField: verifiedKin,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.nextOfKin}",
              );
            },
          ),
          RexListTile(
            title: StringAssets.securityTitle,
            subtitle: StringAssets.securitySubtitle,
            hasTrailingIcon: true,
            verifiedField: verifiedQuestion,
            onTap: () {
              ref
                  .read(securityQuestionListProvider.notifier)
                  .getSecurityQuestionList();
              context.push(
                "${Routes.dashboardMore}/${Routes.securityQuestion}",
              );
            },
          ),
        ],
      ),
    );
  }
}
