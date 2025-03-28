import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/components/business_director_form.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/providers/get_business_director_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessDirectorDetailsScreen extends ConsumerStatefulWidget {
  const BusinessDirectorDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessDirectorDetailsScreen();
}

class _BusinessDirectorDetailsScreen
    extends ConsumerState<BusinessDirectorDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getBusinessDirectorsProvider.notifier).getBusinessDirectors();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var businessDirectors = ref.watch(getBusinessDirectorsProvider);
    List<GetDirectorsResponseData> directors = [];
    int newIndex = 0;

    //
    void addNewDirector() {
      newIndex++;
      setState(() {});
    }

    return AppScaffold(
      isLoading: ref.watch(getBusinessDirectorsProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.businessDirectorDetailsTitle,
        subtitle: StringAssets.updateBusinessDirectorDetails,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.ah),
          businessDirectors.maybeWhen(
              data: (data) {
                return Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      newIndex = index + 1;
                      return DirectorForm(
                        director: data[index],
                        index: index + 1,
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.aw),
                        child: const Divider(
                          thickness: 0.5,
                          color: AppColors.softGrey,
                        )),
                  ),
                );
              },
              orElse: () => const SizedBox.shrink()),
        ],
      ),
      bottomSheet: Container(
        color: AppColors.rexBackground,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: RexElevatedButton(
                onPressed: () {
                  context.push(
                      '${RouteName.dashboardMoreBusiness}/${RouteName.addDirectorForm}');
                },
                buttonTitle: StringAssets.addAnotherDirector,
                backgroundColor: AppColors.rexLightBlue3,
              ),
            ),
            SizedBox(height: 30.ah),
          ],
        ),
      ),
    );
  }
}
