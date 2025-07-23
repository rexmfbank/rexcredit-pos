import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/provider_bills/bill_payment_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/widget/linear_loading_indicator.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';

class SelectBeneficiaryList extends ConsumerStatefulWidget {
  const SelectBeneficiaryList({super.key, required this.onClick});

  final Function(BeneficiaryData) onClick;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectBeneficiaryListState();
}

class _SelectBeneficiaryListState extends ConsumerState<SelectBeneficiaryList> {
  String? selectedId;

  invalidate() {
    var beneficiary = ref.watch(fetchBeneficiaryProvider);
    if (beneficiary.value == null ||
        beneficiary.hasValue ||
        beneficiary.hasError) {
      ref.invalidate(fetchBeneficiaryProvider);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      invalidate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final getData = ref.watch(fetchBeneficiaryProvider);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearLoadingIndicator(loading: getData.isLoading),
              SizedBox(height: 20),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Select Beneficiary",
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.cardGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.asp,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(this.context),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(
                          Icons.close,
                          size: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5),
              getData.when(
                data: (data) {
                  if (data != null && data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Center(child: Text("No beneficiary list")),
                    );
                  }

                  return Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      shrinkWrap: true,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 2.ah),
                      itemCount: data?.length ?? 0,
                      itemBuilder:
                          (context, index) => ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: AppColors.rexLightBlue,
                            title: Text(data?[index].beneficiaryName ?? 'n/a'),
                            subtitle: Text(
                              "${data?[index].beneficiaryAccount}\n${data?[index].finEntityName}",
                            ),
                            isThreeLine: true,
                            onTap: () {
                              widget.onClick.call(data![index]);
                            },
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.red,
                                size: 25.0,
                              ),
                              onPressed: () async {
                                bool result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Are you sure?"),
                                      content: Text(
                                        "Do you want to delete this beneficiary?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, false),
                                          child: Text(StringAssets.cancel),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, true),
                                          child: Text(
                                            StringAssets.delete,
                                            style: TextStyle(
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (result) {
                                  await ref
                                      .read(billPaymentProvider.notifier)
                                      .deleteBeneficiaries(
                                        this.context,
                                        TransactionCodes
                                            .intraBankTransfer
                                            .jsonString,
                                        data?[index].id ?? '',
                                        onSuccess: () {
                                          ref.invalidate(
                                            fetchBeneficiaryProvider,
                                          );
                                        },
                                      );
                                }
                              },
                            ),
                          ),
                    ),
                  );
                },
                error:
                    (error, _) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Center(child: Text('Cannot fetch beneficiaries')),
                    ),
                loading:
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: CircularLoader(height: 20, width: 20),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





/*
class SelectBeneficiaryList extends ConsumerStatefulWidget {
  const SelectBeneficiaryList({
    super.key,
    required this.onClick,
  });

  final Function(BeneficiaryData) onClick;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectBeneficiaryListState();
}

class _SelectBeneficiaryListState extends ConsumerState<SelectBeneficiaryList> {
  @override
  Widget build(BuildContext context) {
    final getData = ref.watch(fetchBeneficiaryProvider);

    return SizedBox(
      height: AppConstants.deviceHeight - 65.ah,
      child: getData.when(
        data: (data) {
          if (data != null && data.isEmpty) {
            return Center(child: Text("No beneficiary list"));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 2.ah),
              itemCount: data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index].beneficiaryName ?? 'n/a'),
                subtitle: Text(
                  "${data[index].beneficiaryAccount}\n${data[index].finEntityName}",
                ),
                isThreeLine: true,
                onTap: () {
                  debugPrint("beneficiary has been selected");
                  widget.onClick.call(data[index]);
                },
              ),
            ),
          );
        },
        error: (error, _) => Center(child: Text('Cannot fetch beneficiaries')),
        loading: () => Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
*/