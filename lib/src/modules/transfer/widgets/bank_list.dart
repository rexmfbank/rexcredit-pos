import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BankList extends ConsumerStatefulWidget {
  const BankList({super.key, required this.onClick});

  final Function(BankData) onClick;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BankListState();
}

class _BankListState extends ConsumerState<BankList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transferExtProvider.notifier).getBanksList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferExtProvider);
    return SizedBox(
      height: AppConstants.deviceHeight - 65.ah,
      child: Column(
        children: [
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.only(left: 16.aw),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Bank",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          state.fetchingBanks
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 2.ah),
                  itemCount: state.banksList.length,
                  itemBuilder: (context, index) {
                    return BankListItem(
                      bankData: state.banksList[index],
                      onTap: () => widget.onClick.call(state.banksList[index]),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}

class BankListItem extends StatelessWidget {
  final BankData bankData;
  final VoidCallback onTap;

  const BankListItem({super.key, required this.bankData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          bankData.name?.toTitleCase() ?? "",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body2Regular.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
