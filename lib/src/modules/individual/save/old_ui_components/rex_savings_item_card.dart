import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/circular_savings_progress_widget.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/date_utils/convert_date_to_maturity_date_string.dart';
import 'package:rex_app/src/utils/double_utils.dart';

class SavingsCardItem extends HookConsumerWidget {
  final dynamic data;

  const SavingsCardItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final logger = ref.watch(loggerProvider);

    String _getImageAssetPath() {
      if (data.status!.active == true) {
        return 'assets/png/savings_icon_two.png';
      } else if (data.status!.closed == true) {
        return 'assets/png/savings_icon_one.png';
      } else if (data.status!.submittedAndPendingApproval == true) {
        return 'assets/png/savings_icon_three.png';
      } else {
        return 'assets/png/savings_icon_two.png';
      }
    }

    String _getStatus() {
      if (data.status!.active == true) {
        return 'Active';
      } else if (data.status!.closed == true) {
        return 'Completed';
      } else if (data.status!.submittedAndPendingApproval == true) {
        return 'Pending';
      } else {
        return '';
      }
    }

    Color _getColorByStatus() {
      if (data.status!.active == true) {
        return Colors.blueAccent;
      } else if (data.status!.closed == true) {
        return AppColors.rexPurpleLight;
      } else if (data.status!.submittedAndPendingApproval == true) {
        return const Color(0xffFBB02C);
      } else {
        return Colors.blueAccent;
      }
    }

    return GestureDetector(
      onTap: () {
        logger.d("Savings ID: ${data.id}");
      },
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.asset(
                      _getImageAssetPath(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 21.0,
                    left: 21.0,
                    child: CircularSavingsProgressWidget(
                      percentage:
                          getRandomPercentage(), // Calculate the savings percentage done
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: _getColorByStatus(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.planName!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            _getStatus(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            addNairaCurrencySymbol(data.targetAmount!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  data.status!.closed != true
                                      ? Icons.lock_open_rounded
                                      : Icons.lock_outline,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  convertDateToReadableDate(
                                    data.maturityDate!,
                                    "yyyy-MM-dd",
                                    false,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
