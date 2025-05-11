import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_model.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_bank_list.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_bottom_modal_sheet.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/payroll_item_types.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final employeeNotifier =
    NotifierProvider<EmployeeNotifier, EmployeeModel>(() => EmployeeNotifier());

class EmployeeNotifier extends Notifier<EmployeeModel> {
  @override
  build() => EmployeeModel(
        personalInfoFormKey: GlobalKey<FormState>(),
        workInfoFormKey: GlobalKey<FormState>(),
        salaryInfoFormKey: GlobalKey<FormState>(),
        allowanceInfoFormKey: GlobalKey<FormState>(),
        deductionInfoFormKey: GlobalKey<FormState>(),
        bankInfoFormKey: GlobalKey<FormState>(),
        scrollController: ScrollController(),
        searchEmployeeController: TextEditingController(),
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        phoneController: TextEditingController(),
        emailController: TextEditingController(),
        departmentController: TextEditingController(),
        designationController: TextEditingController(),
        salaryController: TextEditingController(),
        grossSalaryController: TextEditingController(),
        bankNameController: TextEditingController(),
        accountNameController: TextEditingController(),
        accountNumberController: TextEditingController(),
        swiftCodeController: TextEditingController(),
        allowanceController: TextEditingController(),
        allowanceDescriptionController: TextEditingController(),
        deductionController: TextEditingController(),
        deductionDescriptionController: TextEditingController(),
      );

  void setUpTabController(
          {required int length, required TickerProvider vsync}) =>
      state = state.copyWith(
        employeeTabController: TabController(length: length, vsync: vsync),
      );

  void disposeTabController() => state.employeeTabController?.dispose();

  void updatePaymentGroup(String? value) =>
      state = state.copyWith(paymentGroup: value);

  void updateCurrency(String? value) => state = state.copyWith(currency: value);

  void updateFileDetails(UploadModel model) => state = state.copyWith(
        fileFromDevice: model.fileFromDevice,
        fileName: model.fileName,
      );

  void setEditAction(bool value) => state = state.copyWith(editAction: value);

  void validateEditPersonalInfo(BuildContext context) {
    if (state.personalInfoFormKey.currentState!.validate() &&
        state.firstNameController.text.isNotEmpty &&
        state.lastNameController.text.isNotEmpty &&
        state.phoneController.text.isNotEmpty &&
        state.emailController.text.isNotEmpty) {
      if (state.fileFromDevice != null && state.fileName.isNotBlank) {
        uploadFileToServer(context);
        return;
      }
      updateEmployee(context: context);
    }
  }

  void validatePersonalInfo(BuildContext context) {
    if (state.personalInfoFormKey.currentState!.validate() &&
        state.firstNameController.text.isNotEmpty &&
        state.lastNameController.text.isNotEmpty &&
        state.phoneController.text.isNotEmpty &&
        state.emailController.text.isNotEmpty &&
        state.fileFromDevice != null &&
        state.fileName.isNotBlank) {
      uploadFileToServer(context);
    }
  }

  void validateWorkInfo(BuildContext context) {
    if (state.workInfoFormKey.currentState!.validate() &&
        state.departmentController.text.isNotEmpty &&
        state.designationController.text.isNotEmpty &&
        state.paymentGroup.isNotBlank) {
      if (state.editAction) {
        updateEmployee(context: context);
        return;
      }
      context.push(
          '${RouteName.dashboardBusiness}/${RouteName.employeeSalaryInformation}');
    }
  }

  void validateSalaryInfo(BuildContext context) {
    if (state.salaryInfoFormKey.currentState!.validate() &&
        state.grossSalaryController.text.isNotEmpty &&
        state.currency.isNotBlank) {
      if (state.editAction) {
        updateEmployee(context: context);
        return;
      }
      state = state.copyWith(salaryFilled: true);
      context.pop();
      return;
    }
    state = state.copyWith(salaryFilled: false);
  }

  void clearAllowanceFields() {
    state.allowanceController.clear();
    state.allowanceDescriptionController.clear();
  }

  void clearDeductionFields() {
    state.deductionController.clear();
    state.deductionDescriptionController.clear();
  }

  void allowanceSuccessMessage(BuildContext context) =>
      context.showToast(message: StringAssets.allowanceSuccess);
  void deductionSuccessMessage(BuildContext context) =>
      context.showToast(message: StringAssets.deductionSuccess);

  void validateAddAllowance(BuildContext context) {
    if (state.allowanceInfoFormKey.currentState!.validate() &&
        state.allowanceController.text.isNotEmpty &&
        state.allowanceDescriptionController.text.isNotEmpty) {
      addPayrollItems(
        title: state.allowanceDescriptionController.text,
        amount:
            double.parse(state.allowanceController.text.replaceAll(',', '')),
        type: PayrollItemTypes.allowance.jsonString,
      );
      clearAllowanceFields();
      allowanceSuccessMessage(context);
      state = state.copyWith(allowanceFilled: true);
      return;
    }
    state = state.copyWith(allowanceFilled: false);
  }

  void validateCloseAllowances(BuildContext context) {
    if (state.allowanceInfoFormKey.currentState!.validate() &&
        state.allowanceController.text.isNotEmpty &&
        state.allowanceDescriptionController.text.isNotEmpty) {
      addPayrollItems(
        title: state.allowanceDescriptionController.text,
        amount:
            double.parse(state.allowanceController.text.replaceAll(',', '')),
        type: PayrollItemTypes.allowance.jsonString,
      );
      clearAllowanceFields();
      allowanceSuccessMessage(context);
      context.pop();
      context.pop();
      state = state.copyWith(allowanceFilled: true);
      return;
    }
    state = state.copyWith(allowanceFilled: false);
  }

  void validateAddDeduction(BuildContext context) {
    if (state.deductionInfoFormKey.currentState!.validate() &&
        state.deductionController.text.isNotEmpty &&
        state.deductionDescriptionController.text.isNotEmpty) {
      addPayrollItems(
        title: state.deductionDescriptionController.text,
        amount:
            double.parse(state.deductionController.text.replaceAll(',', '')),
        type: PayrollItemTypes.deduction.jsonString,
      );
      clearDeductionFields();
      deductionSuccessMessage(context);
      state = state.copyWith(deductionFilled: true);
      return;
    }
    state = state.copyWith(deductionFilled: true);
  }

  void validateCloseDeductions(BuildContext context) {
    if (state.deductionInfoFormKey.currentState!.validate() &&
        state.deductionController.text.isNotEmpty &&
        state.deductionDescriptionController.text.isNotEmpty) {
      addPayrollItems(
        title: state.deductionDescriptionController.text,
        amount:
            double.parse(state.deductionController.text.replaceAll(',', '')),
        type: PayrollItemTypes.deduction.jsonString,
      );
      clearDeductionFields();
      deductionSuccessMessage(context);
      context.pop();
      context.pop();
      state = state.copyWith(deductionFilled: true);
      return;
    }
    state = state.copyWith(deductionFilled: true);
  }

  void validateStaffSalaryFields(BuildContext context) {
    if (state.grossSalaryController.text.isNotEmpty &&
        state.payrollItems.any((element) =>
            element.type == PayrollItemTypes.allowance.jsonString) &&
        state.payrollItems.any((element) =>
            element.type == PayrollItemTypes.deduction.jsonString) &&
        state.currency.isNotBlank) {
      context.push(
          '${RouteName.dashboardBusiness}/${RouteName.enterEmployeeBankInformation}');
      return;
    }
    if (context.mounted) {
      showModalActionError(
        context: context,
        errorText: StringAssets.pleaseFillAllRequiredFields,
      );
    }
  }

  void validateBankInfo(BuildContext context) {
    if (state.bankInfoFormKey.currentState!.validate() &&
        state.bankNameController.text.isNotEmpty &&
        state.accountNameController.text.isNotEmpty &&
        state.accountNumberController.text.isNotEmpty) {
      if (state.editAction) {
        updateEmployee(context: context);
        return;
      }
      createEmployee(context: context);
    }
  }

  void addPayrollItems(
      {required String title, required double amount, required String type}) {
    final PayrollItem item = PayrollItem(
      itemCode: AppConstants.guid(),
      staffCode: '',
      type: type,
      title: title,
      amount: amount,
    );
    state = state.copyWith(
      payrollItems: state.payrollItems.toList()..add(item),
    );
  }

  void appendEmployee(BuildContext context) {
    if (state.pageIndex < (state.employeeResponse?.totalPages ?? 0)) {
      if (state.scrollController.offset >=
              state.scrollController.position.maxScrollExtent &&
          !state.scrollController.position.outOfRange) {
        state = state.copyWith(
          pageIndex: state.pageIndex + 1,
          append: true,
        );
        getAllEmployees(context: context);
      }
    }
  }

  Future<void> uploadFileToServer(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.fileFromDevice?.path ?? '',
        fileName: state.fileName ?? '',
      );
      state = state.copyWith(isLoading: false);
      state = state.copyWith(
        employeePhotoLink: uploadResponse.data?.refNo,
      );
      if (context.mounted) {
        context.showToast(message: StringAssets.imageSavedSuccessfully);
        if (state.editAction) {
          updateEmployee(context: context);
          return;
        }
        context.push(
            '${RouteName.dashboardBusiness}/${RouteName.employeeWorkInformation}');
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        context.showToast(message: error.toString());
      }
    }
  }

  Future<void> refreshCall(BuildContext context) async {
    state = state.copyWith(pageIndex: 1, append: false);
    getAllEmployees(context: context);
  }

  Future<void> getAllEmployees({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.getEmployees(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        query: GetAllEmployeesQuery(
          pageNumber: state.pageIndex,
          pageSize: 20,
          businessCode:
              ref.read(loginProvider).loginResponse.value?.data.businessCode ??
                  '',
        ),
      );
      state = state.copyWith(
        isLoading: false,
        employeeList: state.append
            ? (state.employeeList.toList()..addAll(apiResponse.data ?? []))
            : apiResponse.data,
        filteredEmployeeList: state.append
            ? (state.employeeList.toList()..addAll(apiResponse.data ?? []))
            : apiResponse.data,
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void showBankList(BuildContext context) {
    showPlatformBottomSheet(
      context: context,
      backgroundColor: AppColors.rexWhite,
      child: BankList(
        onClick: (value) {
          state = state.copyWith(
            bankCode: value.code,
            bankName: value.name,
            bankSelected: true,
            bankNameController: TextEditingController(text: value.name),
          );
          context.pop();
          ref.read(homeTransferNotifier.notifier).clearBankSearch();
        },
      ),
    );
  }

  void selectEmployee(EmployeeInfoDTO employeeInfo) =>
      state = state.copyWith(selectedEmployeeRes: employeeInfo);

  void fillFields(BuildContext context) {
    if (state.selectedEmployeeRes == null) {
      context.showToast(message: StringAssets.employeeInformationError);
      return;
    }

    state = state.copyWith(
      firstNameController:
          TextEditingController(text: state.selectedEmployeeRes!.firstname),
      lastNameController:
          TextEditingController(text: state.selectedEmployeeRes!.lastname),
      phoneController:
          TextEditingController(text: state.selectedEmployeeRes!.phone),
      emailController:
          TextEditingController(text: state.selectedEmployeeRes!.email),
      departmentController:
          TextEditingController(text: state.selectedEmployeeRes!.department),
      designationController:
          TextEditingController(text: state.selectedEmployeeRes!.designation),
      grossSalaryController: TextEditingController(
          text: state.selectedEmployeeRes!.monthlyGross!.formatCurrencyNum()),
      bankNameController:
          TextEditingController(text: state.selectedEmployeeRes!.bankName),
      accountNameController:
          TextEditingController(text: state.selectedEmployeeRes!.accountName),
      accountNumberController:
          TextEditingController(text: state.selectedEmployeeRes!.accountNumber),
      swiftCodeController:
          TextEditingController(text: state.selectedEmployeeRes!.swiftCode),
      paymentGroup: state.selectedEmployeeRes!.paymentGroup,
      currency: state.selectedEmployeeRes!.salaryCurrency,
    );
  }

  Future<void> clearFields() async {
    state = state.copyWith(
      personalInfoFormKey: GlobalKey<FormState>(),
      workInfoFormKey: GlobalKey<FormState>(),
      salaryInfoFormKey: GlobalKey<FormState>(),
      allowanceInfoFormKey: GlobalKey<FormState>(),
      deductionInfoFormKey: GlobalKey<FormState>(),
      bankInfoFormKey: GlobalKey<FormState>(),
      employeePhotoLink: '',
      paymentGroup: '',
      currency: '',
      bankCode: '',
      bankName: '',
      bankSelected: false,
      salaryFilled: false,
      allowanceFilled: false,
      deductionFilled: false,
      payrollItems: const [],
    );
    state.firstNameController.clear();
    state.lastNameController.clear();
    state.phoneController.clear();
    state.emailController.clear();
    state.departmentController.clear();
    state.designationController.clear();
    state.salaryController.clear();
    state.grossSalaryController.clear();
    state.bankNameController.clear();
    state.accountNameController.clear();
    state.accountNumberController.clear();
    state.swiftCodeController.clear();
    clearAllowanceFields();
    clearDeductionFields();
  }

  Future<void> createEmployee({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.createEmployee(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        request: CreateEmployeeRequest(
          businessCode:
              ref.read(loginProvider).loginResponse.value?.data.businessCode ??
                  '',
          entityCode:
              ref.read(loginProvider).loginResponse.value?.data.entityCode ??
                  '',
          firstname: state.firstNameController.text,
          lastname: state.lastNameController.text,
          phone: state.phoneController.text,
          email: state.emailController.text,
          photoLink: state.employeePhotoLink,
          department: state.departmentController.text,
          paymentGroup: state.paymentGroup,
          designation: state.designationController.text,
          salaryCurrency: state.currency,
          monthlyGross: double.parse(
              state.grossSalaryController.text.trim().replaceAll(',', '')),
          bankName: state.bankNameController.text,
          accountName: state.accountNameController.text,
          accountNumber: state.accountNumberController.text,
          swiftCode: state.swiftCodeController.text,
          payrollItems: state.payrollItems,
        ),
      );
      state = state.copyWith(
        isLoading: false,
        createEmployeeRes: apiResponse.data,
      );
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          title: StringAssets.employeeAdded,
          subtitle: StringAssets.employeeAddedSubtext(
              '${state.createEmployeeRes?.firstname ?? ''} ${state.createEmployeeRes?.lastname ?? ''}'),
          onPressed: () {
            context.pop();
            context.pop();
            context.pop();
            context.pop();
            context.pop();
            getAllEmployees(context: context);
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  Future<void> updateEmployee({required BuildContext context}) async {
    if (state.selectedEmployeeRes == null) {
      context.showToast(message: StringAssets.employeeInformationError);
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.updateEmployee(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        request: CreateEmployeeRequest(
          businessCode:
              ref.read(loginProvider).loginResponse.value?.data.businessCode ??
                  '',
          staffCode: state.selectedEmployeeRes!.businessStaffCode,
          entityCode:
              ref.read(loginProvider).loginResponse.value?.data.entityCode ??
                  '',
          firstname: state.firstNameController.text.isNotEmpty
              ? state.firstNameController.text
              : state.selectedEmployeeRes!.firstname!,
          lastname: state.lastNameController.text.isNotEmpty
              ? state.lastNameController.text
              : state.selectedEmployeeRes!.lastname!,
          phone: state.phoneController.text.isNotEmpty
              ? state.phoneController.text
              : state.selectedEmployeeRes!.phone!,
          email: state.emailController.text.isNotEmpty
              ? state.emailController.text
              : state.selectedEmployeeRes!.email!,
          photoLink: state.employeePhotoLink.isNotBlank
              ? state.employeePhotoLink
              : state.selectedEmployeeRes!.photoLink!,
          department: state.departmentController.text.isNotEmpty
              ? state.departmentController.text
              : state.selectedEmployeeRes!.department!,
          paymentGroup: state.paymentGroup.isNotBlank
              ? state.paymentGroup
              : state.selectedEmployeeRes!.paymentGroup!,
          designation: state.designationController.text.isNotEmpty
              ? state.designationController.text
              : state.selectedEmployeeRes!.designation!,
          salaryCurrency: state.currency.isNotBlank
              ? state.currency
              : state.selectedEmployeeRes!.salaryCurrency!,
          monthlyGross: state.grossSalaryController.text.isNotEmpty
              ? double.parse(
                  state.grossSalaryController.text.trim().replaceAll(',', ''))
              : state.selectedEmployeeRes!.monthlyGross!,
          bankName: state.bankNameController.text.isNotEmpty
              ? state.bankNameController.text
              : state.selectedEmployeeRes!.bankName!,
          accountName: state.accountNameController.text.isNotEmpty
              ? state.accountNameController.text
              : state.selectedEmployeeRes!.accountName!,
          accountNumber: state.accountNumberController.text.isNotEmpty
              ? state.accountNumberController.text
              : state.selectedEmployeeRes!.accountNumber!,
          swiftCode: state.swiftCodeController.text.isNotEmpty
              ? state.swiftCodeController.text
              : state.selectedEmployeeRes!.swiftCode!,
          payrollItems: state.payrollItems.isNotEmpty
              ? state.payrollItems
              : state.selectedEmployeeRes!.payrollItems!,
        ),
      );
      state = state.copyWith(
        isLoading: false,
        createEmployeeRes: apiResponse.data,
      );
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          title: StringAssets.employeeDetailsUpdated,
          subtitle: StringAssets.employeeDetailsUpdatedSubtext(
              '${state.createEmployeeRes?.firstname ?? ''} ${state.createEmployeeRes?.lastname ?? ''}'),
          onPressed: () {
            context.pop();
            context.pop();
            context.pop();
            getAllEmployees(context: context);
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  Future<void> deleteEmployee(
      {required BuildContext context, required String staffCode}) async {
    if (state.selectedEmployeeRes == null) {
      context.showToast(message: StringAssets.employeeInformationError);
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.deleteEmployee(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        staffCode: staffCode,
      );
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          title: StringAssets.employeeDeleted,
          subtitle: StringAssets.employeeDeletedSuccess,
          onPressed: () {
            context.pop();
            context.pop();
            getAllEmployees(context: context);
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void filterEmployee(String query) {
    if (state.employeeList.isNotEmpty) {
      if (query.isEmpty) {
        state = state.copyWith(
          filteredEmployeeList: state.employeeList,
        );
        return;
      }

      final filteredList = state.employeeList.where((employees) {
        final employeeFirstName = employees.firstname?.toLowerCase();
        final employeeLastName = employees.lastname?.toLowerCase();
        final input = query.toLowerCase();

        return (employeeFirstName?.contains(input) == true ||
            employeeLastName?.contains(input) == true);
      }).toList();

      state = state.copyWith(
        filteredEmployeeList: filteredList,
      );
    }
  }
}
