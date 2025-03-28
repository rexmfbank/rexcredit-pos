// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../config/theme/app_colors.dart';

class CreateInvoiceCard extends HookConsumerWidget {
  String? cardTitle;
  String? iconPath;
  String? prefixIconPath;
  VoidCallback? onIconTap;
  String total;

  CreateInvoiceCard(
      {super.key,
      this.cardTitle,
      required this.total,
      this.prefixIconPath,
      this.iconPath,
      this.onIconTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onIconTap,
              child: Image.asset(
                prefixIconPath ?? 'assets/png/receipt_icon.png',
                width: 36,
                height: 36,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle ?? 'Total Savings',
                style: const TextStyle(
                  color: AppColors.rexGreen2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                total,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.cardGrey),
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: onIconTap,
                child: Image.asset(
                  iconPath ?? 'assets/png/save_action_icon.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
