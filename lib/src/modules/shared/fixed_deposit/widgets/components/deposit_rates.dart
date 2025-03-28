import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DepositRates extends ConsumerWidget {
  const DepositRates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return SizedBox(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 3,
                      child: CachedNetworkImage(
                        imageUrl: _url,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(
                          child: Text(StringAssets.depositRates1),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.ah),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        StringAssets.dismissTextOnBtn,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 16.0, top: 16.0),
        child: Text(
          StringAssets.depositRates2,
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

const _url =
    "https://productlogos.s3.us-west-2.amazonaws.com/13148_WhatsApp_Image_2024-01-26_at_4.04.42_PM.jpeg";
