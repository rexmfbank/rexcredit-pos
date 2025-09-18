import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TransferRateScreen extends StatefulWidget {
  const TransferRateScreen({super.key});

  @override
  State<TransferRateScreen> createState() => _TransferRateScreenState();
}

class _TransferRateScreenState extends State<TransferRateScreen> {
  late final TextEditingController _searchController;
  String _query = '';
  static const _title = 'Bank Transfer Success Rate';
  static const _subtitle = 'View all bank transfer success rate';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    final currentQuery = _searchController.text.trim().toLowerCase();
    if (currentQuery != _query) {
      setState(() {
        _query = currentQuery;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _query;
    final List<_TransferRateBank> filteredBanks =
        query.isEmpty
            ? List<_TransferRateBank>.of(_bankRates)
            : _bankRates
                .where((bank) => bank.name.toLowerCase().contains(query))
                .toList(growable: false);

    return AppScaffold(
      backgroundColor: AppColors.rexTint800,
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: _title,
        subtitle: _subtitle,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.ah),
          _TransferRateSearchField(controller: _searchController),
          SizedBox(height: 16.ah),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.circular(16.ar),
              ),
              child:
                  filteredBanks.isEmpty
                      ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.aw),
                          child: Text(
                            'No banks matched your search.',
                            style: AppTextStyles.body2Regular.copyWith(
                              color: AppColors.rexTint400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 8.ah),
                        itemCount: filteredBanks.length,
                        separatorBuilder:
                            (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.aw),
                              child: Divider(
                                height: 1.ah,
                                color: AppColors.rexTint300,
                              ),
                            ),
                        itemBuilder: (context, index) {
                          final bank = filteredBanks[index];
                          return _TransferRateTile(bank: bank);
                        },
                      ),
            ),
          ),
          SizedBox(height: 16.ah),
        ],
      ),
    );
  }
}

class _TransferRateSearchField extends StatelessWidget {
  const _TransferRateSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.rexWhite,
        hintText: 'Search Bank',
        hintStyle: AppTextStyles.body2Regular.copyWith(
          color: AppColors.rexTint400,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.aw,
          vertical: 16.ah,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.aw),
          child: SvgPicture.asset(
            AssetPath.search,
            width: 20.aw,
            height: 20.ah,
            colorFilter: ColorFilter.mode(
              AppColors.rexTint400,
              BlendMode.srcIn,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 24.aw),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.ar),
          borderSide: BorderSide(color: Colors.transparent, width: 0.5.ar),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.ar),
          borderSide: BorderSide(color: Colors.transparent, width: 0.5.ar),
        ),
      ),
    );
  }
}

class _TransferRateTile extends StatelessWidget {
  const _TransferRateTile({required this.bank});

  final _TransferRateBank bank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 12.ah),
      child: Row(
        children: [
          _BankAvatar(bank: bank),
          SizedBox(width: 12.aw),
          Expanded(
            child: Text(
              bank.name,
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          _SuccessBadge(rate: bank.successRate),
        ],
      ),
    );
  }
}

class _BankAvatar extends StatelessWidget {
  const _BankAvatar({required this.bank});

  final _TransferRateBank bank;

  @override
  Widget build(BuildContext context) {
    final initials =
        bank.name.isNotEmpty
            ? bank.name
                .trim()
                .split(' ')
                .map((part) => part.isEmpty ? '' : part[0])
                .take(2)
                .join()
                .toUpperCase()
            : '';

    return Container(
      width: 44.aw,
      height: 44.aw,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.rexTint800,
      ),
      child: ClipOval(
        child:
            bank.assetPath != null
                ? Image.asset(bank.assetPath!, fit: BoxFit.cover)
                : Center(
                  child: Text(
                    initials,
                    style: AppTextStyles.body2Regular.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.rexPurpleLight,
                    ),
                  ),
                ),
      ),
    );
  }
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge({required this.rate});

  final int rate;

  @override
  Widget build(BuildContext context) {
    final clampedRate = rate.clamp(0, 100);
    final progress = clampedRate / 100;

    return SizedBox(
      width: 48.aw,
      height: 48.aw,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 48.aw,
            height: 48.aw,
            child: CircularProgressIndicator(
              value: progress.toDouble(),
              strokeWidth: 4.aw,
              backgroundColor: AppColors.rexTint300,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.rexLightBlue3,
              ),
            ),
          ),
          Container(
            width: 36.aw,
            height: 36.aw,
            decoration: const BoxDecoration(
              color: AppColors.rexWhite,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$rate%',
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferRateBank {
  const _TransferRateBank({
    required this.name,
    required this.successRate,
    this.assetPath,
  });

  final String name;
  final int successRate;
  final String? assetPath;
}

const List<_TransferRateBank> _bankRates = [
  _TransferRateBank(
    name: 'Access Bank',
    successRate: 97,
    assetPath: AssetPath.bankTransferIcon1,
  ),
  _TransferRateBank(
    name: 'ALAT by WEMA',
    successRate: 96,
    assetPath: AssetPath.bankTransferIcon2,
  ),
  _TransferRateBank(
    name: 'Citibank Nigeria',
    successRate: 99,
    assetPath: AssetPath.bankTransferIcon3,
  ),
  _TransferRateBank(
    name: 'Ecobank Nigeria',
    successRate: 95,
    assetPath: AssetPath.bankTransferIcon4,
  ),
  _TransferRateBank(
    name: 'First City Monument Bank',
    successRate: 98,
    assetPath: AssetPath.bankTransferIcon1,
  ),
  _TransferRateBank(
    name: 'Globus Bank',
    successRate: 96,
    assetPath: AssetPath.bankTransferIcon2,
  ),
  _TransferRateBank(
    name: 'Guaranty Trust Bank',
    successRate: 97,
    assetPath: AssetPath.bankTransferIcon3,
  ),
  _TransferRateBank(
    name: 'Providus Bank',
    successRate: 95,
    assetPath: AssetPath.bankTransferIcon4,
  ),
  _TransferRateBank(
    name: 'Polaris Bank',
    successRate: 99,
    assetPath: AssetPath.bankTransferIcon1,
  ),
  _TransferRateBank(
    name: 'Kuda',
    successRate: 98,
    assetPath: AssetPath.bankTransferIcon2,
  ),
];
