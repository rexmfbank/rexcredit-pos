import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class EmployeeModel {
  final GlobalKey<FormState> personalInfoFormKey;
  final GlobalKey<FormState> workInfoFormKey;
  final GlobalKey<FormState> salaryInfoFormKey;
  final GlobalKey<FormState> allowanceInfoFormKey;
  final GlobalKey<FormState> deductionInfoFormKey;
  final GlobalKey<FormState> bankInfoFormKey;
  final TabController? employeeTabController;
  final ScrollController scrollController;
  final TextEditingController searchEmployeeController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController departmentController;
  final TextEditingController designationController;
  final TextEditingController salaryController;
  final TextEditingController grossSalaryController;
  final TextEditingController bankNameController;
  final TextEditingController accountNameController;
  final TextEditingController accountNumberController;
  final TextEditingController swiftCodeController;
  final TextEditingController allowanceController;
  final TextEditingController allowanceDescriptionController;
  final TextEditingController deductionController;
  final TextEditingController deductionDescriptionController;
  final List<PayrollItem> payrollItems;
  final List<String> employeeTabs;
  final List<String> paymentGroups;
  final List<EmployeeInfoDTO> employeeList;
  final List<EmployeeInfoDTO> filteredEmployeeList;
  final GetEmployeeResponse? employeeResponse;
  final EmployeeInfoDTO? createEmployeeRes;
  final EmployeeInfoDTO? selectedEmployeeRes;
  final ImageUploadResponse? employeeImageRes;
  final File? fileFromDevice;
  final String? fileName;
  final String employeePhotoLink;
  final String paymentGroup;
  final String currency;
  final String bankCode;
  final String bankName;
  final int pageIndex;
  final bool isLoading;
  final bool append;
  final bool editAction;
  final bool bankSelected;
  final bool salaryFilled;
  final bool allowanceFilled;
  final bool deductionFilled;

  const EmployeeModel({
    required this.personalInfoFormKey,
    required this.workInfoFormKey,
    required this.salaryInfoFormKey,
    required this.allowanceInfoFormKey,
    required this.deductionInfoFormKey,
    required this.bankInfoFormKey,
    required this.scrollController,
    required this.searchEmployeeController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.departmentController,
    required this.designationController,
    required this.salaryController,
    required this.grossSalaryController,
    required this.bankNameController,
    required this.accountNameController,
    required this.accountNumberController,
    required this.swiftCodeController,
    required this.allowanceController,
    required this.allowanceDescriptionController,
    required this.deductionController,
    required this.deductionDescriptionController,
    this.employeeTabController,
    this.employeeTabs = const ['Employees', 'Payroll'],
    this.paymentGroups = const [
      '0-50k',
      '50 - 100k',
      '100 - 400k',
      '400 - 900k',
      '900 - 1,500,000',
      '1,500,000+'
    ],
    this.employeeList = const [],
    this.filteredEmployeeList = const [],
    this.payrollItems = const [],
    this.employeeResponse,
    this.createEmployeeRes,
    this.selectedEmployeeRes,
    this.fileFromDevice,
    this.fileName,
    this.employeeImageRes,
    this.employeePhotoLink = '',
    this.paymentGroup = '',
    this.currency = '',
    this.bankCode = '',
    this.bankName = '',
    this.pageIndex = 1,
    this.append = false,
    this.editAction = false,
    this.isLoading = false,
    this.bankSelected = false,
    this.salaryFilled = false,
    this.allowanceFilled = false,
    this.deductionFilled = false,
  });

  @override
  EmployeeModel copyWith({
    GlobalKey<FormState>? personalInfoFormKey,
    GlobalKey<FormState>? workInfoFormKey,
    GlobalKey<FormState>? salaryInfoFormKey,
    GlobalKey<FormState>? allowanceInfoFormKey,
    GlobalKey<FormState>? deductionInfoFormKey,
    GlobalKey<FormState>? bankInfoFormKey,
    TabController? employeeTabController,
    ScrollController? scrollController,
    TextEditingController? searchEmployeeController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? phoneController,
    TextEditingController? emailController,
    TextEditingController? departmentController,
    TextEditingController? designationController,
    TextEditingController? salaryController,
    TextEditingController? grossSalaryController,
    TextEditingController? bankNameController,
    TextEditingController? accountNameController,
    TextEditingController? accountNumberController,
    TextEditingController? swiftCodeController,
    TextEditingController? allowanceController,
    TextEditingController? allowanceDescriptionController,
    TextEditingController? deductionController,
    TextEditingController? deductionDescriptionController,
    List<PayrollItem>? payrollItems,
    List<String>? employeeTabs,
    List<String>? paymentGroups,
    List<EmployeeInfoDTO>? employeeList,
    List<EmployeeInfoDTO>? filteredEmployeeList,
    GetEmployeeResponse? employeeResponse,
    EmployeeInfoDTO? createEmployeeRes,
    EmployeeInfoDTO? selectedEmployeeRes,
    ImageUploadResponse? employeeImageRes,
    File? fileFromDevice,
    String? fileName,
    String? employeePhotoLink,
    String? paymentGroup,
    String? currency,
    String? bankCode,
    String? bankName,
    int? pageIndex,
    bool? append,
    bool? editAction,
    bool? isLoading,
    bool? bankSelected,
    bool? salaryFilled,
    bool? allowanceFilled,
    bool? deductionFilled,
  }) {
    return EmployeeModel(
      isLoading: isLoading ?? this.isLoading,
      editAction: editAction ?? this.editAction,
      append: append ?? this.append,
      personalInfoFormKey: personalInfoFormKey ?? this.personalInfoFormKey,
      workInfoFormKey: workInfoFormKey ?? this.workInfoFormKey,
      salaryInfoFormKey: salaryInfoFormKey ?? this.salaryInfoFormKey,
      allowanceInfoFormKey: allowanceInfoFormKey ?? this.allowanceInfoFormKey,
      deductionInfoFormKey: deductionInfoFormKey ?? this.deductionInfoFormKey,
      bankInfoFormKey: bankInfoFormKey ?? this.bankInfoFormKey,
      employeeTabController:
          employeeTabController ?? this.employeeTabController,
      scrollController: scrollController ?? this.scrollController,
      searchEmployeeController:
          searchEmployeeController ?? this.searchEmployeeController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      phoneController: phoneController ?? this.phoneController,
      emailController: emailController ?? this.emailController,
      departmentController: departmentController ?? this.departmentController,
      designationController:
          designationController ?? this.designationController,
      salaryController: salaryController ?? this.salaryController,
      grossSalaryController:
          grossSalaryController ?? this.grossSalaryController,
      bankNameController: bankNameController ?? this.bankNameController,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      bankSelected: bankSelected ?? this.bankSelected,
      accountNameController:
          accountNameController ?? this.accountNameController,
      accountNumberController:
          accountNumberController ?? this.accountNumberController,
      swiftCodeController: swiftCodeController ?? this.swiftCodeController,
      allowanceController: allowanceController ?? this.allowanceController,
      allowanceDescriptionController:
          allowanceDescriptionController ?? this.allowanceDescriptionController,
      deductionController: deductionController ?? this.deductionController,
      deductionDescriptionController:
          deductionDescriptionController ?? this.deductionDescriptionController,
      payrollItems: payrollItems ?? this.payrollItems,
      employeeTabs: employeeTabs ?? this.employeeTabs,
      paymentGroups: paymentGroups ?? this.paymentGroups,
      employeeResponse: employeeResponse ?? this.employeeResponse,
      createEmployeeRes: createEmployeeRes ?? this.createEmployeeRes,
      selectedEmployeeRes: selectedEmployeeRes ?? this.selectedEmployeeRes,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      employeeImageRes: employeeImageRes ?? this.employeeImageRes,
      employeePhotoLink: employeePhotoLink ?? this.employeePhotoLink,
      paymentGroup: paymentGroup ?? this.paymentGroup,
      currency: currency ?? this.currency,
      salaryFilled: salaryFilled ?? this.salaryFilled,
      allowanceFilled: allowanceFilled ?? this.allowanceFilled,
      deductionFilled: deductionFilled ?? this.deductionFilled,
      pageIndex: pageIndex ?? this.pageIndex,
      employeeList: employeeList ?? this.employeeList,
      filteredEmployeeList: filteredEmployeeList ?? this.filteredEmployeeList,
    );
  }
}
