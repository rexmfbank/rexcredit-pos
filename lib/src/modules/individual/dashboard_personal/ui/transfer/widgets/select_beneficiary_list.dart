import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

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
