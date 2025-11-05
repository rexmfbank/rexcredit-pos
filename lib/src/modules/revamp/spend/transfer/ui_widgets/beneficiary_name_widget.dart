import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BeneficiaryNameWidget extends StatelessWidget {
  final String beneficiaryName;
  final String? title;
  final Function()? onTap;

  const BeneficiaryNameWidget({
    super.key,
    required this.beneficiaryName,
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.ar),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? Strings.beneficiaryName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: AppColors.rexPurpleDark,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(beneficiaryName, style: const TextStyle(fontSize: 15.0)),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.close, size: 15, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class BeneficiaryInfoWidget extends StatelessWidget {
  final String beneficiarySelected;
  final String beneficiaryName;
  final String beneficiaryBank;
  final String beneficiaryAccountNumber;
  final Function(bool) onCheckboxChanged;
  final VoidCallback? onDelete;

  const BeneficiaryInfoWidget({
    super.key,
    required this.beneficiarySelected,
    required this.beneficiaryName,
    required this.beneficiaryBank,
    required this.beneficiaryAccountNumber,
    required this.onCheckboxChanged,
    this.onDelete,
  });

  bool get _selected => beneficiaryAccountNumber == beneficiarySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.ar),
      decoration: BoxDecoration(
        color: _selected ? AppColors.rexLightBlue : Colors.white,
        borderRadius: BorderRadius.circular(12.ar),
        border: Border.all(
          color: _selected ? AppColors.rexLightBlue2 : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beneficiaryName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.asp,
                    color: Colors.black, // You can change the color
                  ),
                ),
                SizedBox(height: 8.ah),
                Text(
                  beneficiaryBank,
                  style: TextStyle(fontSize: 14.asp, color: AppColors.cardGrey),
                ),
                SizedBox(height: 4.ah),
                Text(
                  beneficiaryAccountNumber,
                  style: TextStyle(fontSize: 14.asp, color: AppColors.cardGrey),
                ),
              ],
            ),
          ),
          Checkbox(
            value: _selected,
            onChanged: (value) => onCheckboxChanged(value ?? false),
          ),
          SizedBox(width: 8.aw),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Do you want to delete this beneficiary?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(Strings.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          if (onDelete != null) {
                            Navigator.of(context).pop();
                            onDelete!();
                          }
                        },
                        child: Text(
                          Strings.delete,
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
              // Implement delete functionality here
              // For example, you can call a method to delete the beneficiary
            },
            icon: Icon(Icons.delete, color: AppColors.red, size: 25.0),
          ),
        ],
      ),
    );
  }
}

class BeneficiaryCell extends StatelessWidget {
  final String beneficiarySelected;
  final String beneficiaryName;
  final String beneficiaryBank;
  final String beneficiaryAccountNumber;
  final Function() onTap;
  final VoidCallback? onDelete;

  const BeneficiaryCell({
    super.key,
    required this.beneficiarySelected,
    required this.beneficiaryName,
    required this.beneficiaryBank,
    required this.beneficiaryAccountNumber,
    required this.onTap,
    this.onDelete,
  });

  bool get _selected => beneficiaryAccountNumber == beneficiarySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.rexLightBlue,
        borderRadius: BorderRadius.circular(10.ar),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    beneficiaryName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.asp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.ah),
                  Text(
                    beneficiaryBank,
                    style: TextStyle(
                      fontSize: 14.asp,
                      color: AppColors.cardGrey,
                    ),
                  ),
                  SizedBox(height: 4.ah),
                  Text(
                    beneficiaryAccountNumber,
                    style: TextStyle(
                      fontSize: 14.asp,
                      color: AppColors.cardGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.aw),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Do you want to delete this beneficiary?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(Strings.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          if (onDelete != null) {
                            Navigator.of(context).pop();
                            onDelete!();
                          }
                        },
                        child: Text(
                          Strings.delete,
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
              // Implement delete functionality here
              // For example, you can call a method to delete the beneficiary
            },
            icon: Icon(Icons.delete, color: AppColors.red, size: 25.0),
          ),
        ],
      ),
    );
  }
}
