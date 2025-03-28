import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/business/borrow/screens/agent_screens/agent_loan_dashboard.dart';
import 'package:rex_app/src/modules/business/borrow/screens/agent_screens/agent_loan_recommend_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/agent_screens/agent_loan_request_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_bank_statement_confirm_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_bank_statement_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_documents_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_id_verify_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_loan_application_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_loan_calculation_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/business_loan_submission_screen.dart';
import 'package:rex_app/src/modules/business/borrow/screens/dashboard_borrow_business.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/create_payment_link_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/dashboard_payments.dart';
import 'package:rex_app/src/modules/business/cashflow/payments/preview_payment_link_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_add_line_items_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_all_invoices_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_invoice_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_manage_invoice_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_preview_invoice_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_receipt_detail_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_receipts_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/cashflow_transactions_screen.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/dashboard_cashflow.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_add_card_webview.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_add_money_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/account_card/dashboard_business_topup_amount_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_add_card_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_loan_offer_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/business_loan_repayment.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/components/dashboard_business.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/screens/dashboard_spend_business.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_all_transactions_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_transaction_detail_screen.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/transactions/business_transaction_dispute_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/dashboard_employee.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/create_payroll_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/payroll_summary_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/payslip_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/prepare_payroll_employees_on_loan_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/prepare_payroll_salary_breakdown.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/prepare_payroll_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/employee_allowances_list.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/employee_deductions_list.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/employee_salary_information.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_employee_allowance_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_employee_bank_information_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_employee_deductions_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/enter_employee_information_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_employee_personal_information.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_employee_work_information_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/onboarding/enter_salary_amount.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/single_employee_screen.dart';
import 'package:rex_app/src/modules/business/more/bank_statement/business_request_statement_screen.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_create_pin.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_replacement_page.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_request_summary.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_transaction_limit.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/new_cards_screen.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/request_card_form.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/reset_card_pin.dart';
import 'package:rex_app/src/modules/business/more/faq/business_faq_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/components/add_director_form.dart';
import 'package:rex_app/src/modules/business/more/profile/business_directors/screens/business_directors_detail_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/screens/business_info_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/screens/edit_business_info_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_kyc_documents.dart';
import 'package:rex_app/src/modules/business/more/profile/business_profile_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_profile_setup_withdrawal_limit.dart';
import 'package:rex_app/src/modules/business/more/profile/business_representative_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_security_question_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/business_setup_biometric_screen.dart';
import 'package:rex_app/src/modules/business/more/profile/enter_transaction_pin_security_question_screen.dart';
import 'package:rex_app/src/modules/business/more/referral/business_referral_screen.dart';
import 'package:rex_app/src/modules/business/more/request_pos/request_pos_cac_document_screen.dart';
import 'package:rex_app/src/modules/business/more/request_pos/request_pos_director_id_verification_screen.dart';
import 'package:rex_app/src/modules/business/more/request_pos/request_pos_screen.dart';
import 'package:rex_app/src/modules/business/more/request_pos/request_pos_utility_bill_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/audit_log_detail_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_delivery_confirm_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_delivery_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_spend_limit_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/cards_track_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/dashboard_business_more.dart';
import 'package:rex_app/src/modules/business/more/screens/more_audit_logs_screen.dart';
import 'package:rex_app/src/modules/business/more/screens/virtual_card_application_screen.dart';
import 'package:rex_app/src/modules/business/more/support/business_chat_screen.dart';
import 'package:rex_app/src/modules/business/more/terms_condition_and_privacy/terms_and_conditons_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_add_user_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_create_role_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_user_management_screen.dart';
import 'package:rex_app/src/modules/business/more/user_management/ui/screens/business_view_users_screen.dart';
import 'package:rex_app/src/modules/business/save/fixed_deposits/business_fixed_deposit_card_screen.dart';
import 'package:rex_app/src/modules/business/save/fixed_deposits/business_fixed_deposit_detail_screen.dart';
import 'package:rex_app/src/modules/business/save/fixed_deposits/business_fixed_deposit_start_screen.dart';
import 'package:rex_app/src/modules/business/save/fixed_deposits/business_fixed_deposit_summary_screen.dart';
import 'package:rex_app/src/modules/business/save/fixed_deposits/business_fixed_deposit_webview.dart';
import 'package:rex_app/src/modules/business/save/target_savings/business_target_saving_card_screen.dart';
import 'package:rex_app/src/modules/business/save/target_savings/business_target_saving_detail_screen.dart';
import 'package:rex_app/src/modules/business/save/target_savings/business_target_saving_start_screen.dart';
import 'package:rex_app/src/modules/business/save/target_savings/business_target_saving_summary_screen.dart';
import 'package:rex_app/src/modules/business/save/target_savings/business_target_saving_webview.dart';
import 'package:rex_app/src/modules/business/save/ui/dashboard_save_business.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/dashboard_borrow.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_guarantor_details_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_active_loan_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_application_applied_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_application_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_calculation_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_connect_bank_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_employee_type_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_employment_profile_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_personal_details_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/individual_loan_public_agencies_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/loan_repayment/loan_part_payment_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/loan_repayment/loan_termination_screen.dart';
import 'package:rex_app/src/modules/individual/borrow/screens/public_employee_connect_bank_details_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_add_card_webview.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_add_money_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_bank_transfer_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_saved_cards_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/account_card/dashboard_topup_amount_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/dashboard_individual.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_all_transactions_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_transaction_detail_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transactions/individual_transaction_dispute_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/dashboard_home_transfer.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/transfer/transfers_page.dart';
import 'package:rex_app/src/modules/individual/more/bank_statement/individual_request_statement_screen.dart';
import 'package:rex_app/src/modules/individual/more/faqs/ui/screens/faq_screen.dart';
import 'package:rex_app/src/modules/individual/more/privacy_and_terms/legals_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/change_password_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/edit_residential_address_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/enter_old_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/enter_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/new_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/next_of_kin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_info_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/personal_profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/reset_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/screens/security_question_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/customer_support_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/individual_chat_screen.dart';
import 'package:rex_app/src/modules/individual/more/support/ui/screens/individual_disputes_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/add_document_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/add_documents_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/additional_documents_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/change_password_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/confirm_new_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/dashboard_more.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/enter_bvn_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/enter_new_pin_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/individual_referral_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/new_pin_changed_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/next_of_kin_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/request_pos_screen.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/security_question_confirm_screen.dart';
import 'package:rex_app/src/modules/individual/more/update_account/update_account_screen.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/purchase_amount_screen.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/purchase_pin_screen.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/purchase_screen.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/purchase_status_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/dashboard_individual_save_screeen.dart';
import 'package:rex_app/src/modules/individual/save/ui/dashboard_individual_select_saving_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/fixed_deposit_screens/individual_fixed_deposit_card_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/fixed_deposit_screens/individual_fixed_deposit_detail_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/fixed_deposit_screens/individual_fixed_deposit_start_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/fixed_deposit_screens/individual_fixed_deposit_summary_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/fixed_deposit_screens/individual_fixed_deposit_webview.dart';
import 'package:rex_app/src/modules/individual/save/ui/target_savings_screens/individual_target_saving_card_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/target_savings_screens/individual_target_saving_detail_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/target_savings_screens/individual_target_saving_start_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/target_savings_screens/individual_target_saving_summary_screen.dart';
import 'package:rex_app/src/modules/individual/save/ui/target_savings_screens/individual_target_saving_webview.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/screens/airtime_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/screens/bill_payment_airtime_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_cable/screens/bill_payment_cable_tv_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_cable/screens/bill_payment_cable_tv_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/screens/bill_payment_data_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/screens/bill_payment_data_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_education/screens/bill_payment_education_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_education/screens/bill_payment_education_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/screens/bill_payment_electricity_screen.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/screens/electricity_confirm_screen.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/screens/bank_uptime_screen.dart';
import 'package:rex_app/src/modules/shared/spend/widgets/dashboard_spend.dart';

final dashboardHomeRoutes = GoRoute(
  path: RouteName.dashboardIndividual,
  builder: (context, state) => const DashboardIndividual(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.transferMoney,
      builder: (context, state) => const DashboardHomeTransferScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.transferTabPage,
      builder: (context, state) => const TransfersPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bankUptime,
      builder: (context, state) => const BankUptimeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardAddMoney,
      builder: (context, state) => const DashboardAddMoneyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardSavedCards,
      builder: (context, state) => const DashboardSavedCardsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardTopUpAmount,
      builder: (context, state) => const DashboardTopUpAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardAddCardWebview,
      builder: (context, state) => const DashboardAddCardWebView(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBankTransfer,
      builder: (context, state) => const DashboardBankTransferScreen(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.transferReceipt,
    //   builder: (context, state) =>  TransferReceiptScreen(),
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualAllTransactions,
      builder: (context, state) => const IndividualAllTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTransactionDetail,
      builder: (context, state) => const IndividualTransactionDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTransactionDispute,
      builder: (context, state) => const IndividualTransactionDisputeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.purchaseScreen,
      builder: (context, state) => const PurchaseScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.purchaseAmount,
      builder: (context, state) => const PurchaseAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.purchasePin,
      builder: (context, state) => const PurchasePinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.purchaseStatus,
      builder: (context, state) => const PurchaseStatusScreen(),
    ),
  ],
);

final dashboardHomeBusinessRoutes = GoRoute(
  path: RouteName.dashboardBusiness,
  builder: (context, state) => const DashboardBusiness(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBusinessAddMoney,
      builder: (context, state) => const DashboardBusinessAddMoneyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBusinessSavedCards,
      builder: (context, state) => const DashboardSavedCardsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBusinessTopupAmount,
      builder: (context, state) => const DashboardBusinessTopupAmountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBusinessAddCardWebview,
      builder: (context, state) => const DashboardBusinessAddCardWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardBusinessBankTransfer,
      builder: (context, state) => const DashboardBusinessBankTransferScreen(),
    ),
    GoRoute(
      path: RouteName.dashboardEmployees,
      builder: (context, state) => const DashboardEmployeeScreen(),
    ),
    GoRoute(
      path: RouteName.dashboardCashflow,
      builder: (context, state) => const DashboardCashflowScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterEmployeeInformation,
      builder: (context, state) => const EmployeePersonalInformationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeWorkInformation,
      builder: (context, state) {
        var edit = (state.extra ?? false) as bool;
        return EmployeeWorkInformationScreen(edit: edit);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeSalaryInformation,
      builder: (context, state) {
        var edit = (state.extra ?? false) as bool;
        return EmployeeSalaryInformationScreen(edit: edit);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterSalaryAmount,
      builder: (context, state) {
        var edit = (state.extra ?? false) as bool;
        return EmployeeSalaryAmountScreen(edit: edit);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeAllowancesList,
      builder: (context, state) => const EmployeeAllowancesList(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeDeductionsList,
      builder: (context, state) => const EmployeeDeductionsList(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterEmployeeAllowances,
      builder: (context, state) => const EmployeeAllowancesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterEmployeeDeductions,
      builder: (context, state) => const EmployeeDeductionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterEmployeeBankInformation,
      builder: (context, state) {
        var edit = (state.extra ?? false) as bool;
        return EmployeeBankInformationScreen(edit: edit);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.singleEmployee,
      builder: (context, state) => const SingleEmployeeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeePersonalDetails,
      builder: (context, state) {
        var edit = (state.extra ?? false) as bool;
        return UpdateEmployeePersonalInformationScreen(edit: edit);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.createPayroll,
      builder: (context, state) => const CreatePayrollScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.preparePayroll,
      builder: (context, state) => const PreparePayrollScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.preparePayrollEmployeeLoan,
      builder: (context, state) => const PreparePayrollEmployeeLoanScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.reviewSalaryBreakdown,
      builder: (context, state) => const PayrollReviewSalaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeePayslip,
      builder: (context, state) => const PayslipScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.payrollSummary,
      builder: (context, state) => const PayrollSummaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowTransactions,
      builder: (context, state) => CashflowTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowInvoice,
      builder: (context, state) => const CashflowInvoiceScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowAllInvoice,
      builder: (context, state) => const CashFlowAllInvoiceScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowPreviewInvoice,
      builder: (context, state) => const CashFlowPreviewInvoiceScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.manageInvoice,
      builder: (context, state) => const CashFlowManageInvoiceScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addLineItems,
      builder: (context, state) => const CashflowAddLineItemsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowReceipt,
      builder: (context, state) => const CashFlowReceiptsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowReceiptDetail,
      builder: (context, state) => const CashFlowReceiptDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cashflowPayments,
      builder: (context, state) => const DashboardPaymentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.paymentLink,
      builder: (context, state) => const CreatePaymentLinkScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.previewPaymentLink,
      builder: (context, state) => const PreviewPaymentLinkScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessLoanOffer,
      builder: (context, state) => const BusinessLoanOfferScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessLoanRepayment,
      builder: (context, state) => const BusinessLoanRepayment(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessAddCard,
      builder: (context, state) => const BusinessAddCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessAllTransactions,
      builder: (context, state) => const BusinessAllTransactionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessTransactionDetail,
      builder: (context, state) => const BusinessTransactionDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessTransactionDispute,
      builder: (context, state) => const BusinessTransactionDisputeScreen(),
    ),
  ],
);

final dashboardSpendRoutes = GoRoute(
  path: RouteName.dashboardSpend,
  builder: (context, state) => const DashboardSpend(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billAirtime,
      builder: (context, state) => const BillPaymentAirtimeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billData,
      builder: (context, state) => const BillPaymentDataScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billCableTv,
      builder: (context, state) => const BillPaymentCableTvScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billElectricity,
      builder: (context, state) => const BillPaymentElectricityScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billEducation,
      builder: (context, state) => const BillPaymentEducationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billDataConfirm,
      builder: (context, state) => const BillPaymentDataConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billCableTvConfirm,
      builder: (context, state) => const BillPaymentCableTvConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billElectricityConfirm,
      builder: (context, state) => const ElectricityConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billEducationConfirm,
      builder: (context, state) => const BillPaymentEducationConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.billAirtimeConfirm,
      builder: (context, state) => const AirtimeConfirmScreen(),
    ),
  ],
);

final dashboardSaveRoutes = GoRoute(
  path: RouteName.dashboardSave,
  builder: (context, state) {
    var initPage = (state.extra ?? 0) as int;
    return DashboardIndividualSaveScreen(initPage: initPage);
  },
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualFixedDepositWebview,
      builder: (context, state) => const IndividualFixedDepositWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualFixedDepositCard,
      builder: (context, state) => const IndividualFixedDepositCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualFixedDepositSummary,
      builder: (context, state) => const IndividualFixedDepositSummaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualFixedDeposit,
      builder: (context, state) => const IndividualFixedDepositStartScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTargetSaving,
      builder: (context, state) => const IndividualTargetSavingStartScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.dashboardIndividualSelectSaving,
      builder: (context, state) =>
          const DashboardIndividualSelectSavingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTargetSavingSummary,
      builder: (context, state) => const IndividualTargetSavingSummaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTargetSavingCard,
      builder: (context, state) => const IndividualTargetSavingCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTargetSavingWebview,
      builder: (context, state) => const IndividualTargetSavingWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualTargetSavingDetail,
      builder: (context, state) => const IndividualTargetSavingDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualFixedDepositDetail,
      builder: (context, state) => const IndividualFixedDepositDetailScreen(),
    )
  ],
);

final dashboardSaveBusinessRoutes = GoRoute(
  path: RouteName.dashboardSaveBusiness,
  builder: (context, state) => const DashboardSaveBusiness(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizFixedDepositWebview,
      builder: (context, state) => const BusinessFixedDepositWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizFixedDepositCard,
      builder: (context, state) => const BusinessFixedDepositCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizFixedDepositSummary,
      builder: (context, state) => const BusinessFixedDepositSummaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizFixedDeposit,
      builder: (context, state) => const BusinessFixedDepositStartScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizTargetSaving,
      builder: (context, state) => const BusinessTargetSavingStartScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizTargetSavingSummary,
      builder: (context, state) => const BusinessTargetSavingSummaryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizTargetSavingCard,
      builder: (context, state) => const BusinessTargetSavingCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizTargetSavingWebview,
      builder: (context, state) => const BusinessTargetSavingWebview(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizTargetSavingDetail,
      builder: (context, state) => const BusinessTargetSavingDetailScreen(),
    ),
    GoRoute(
      path: RouteName.bizFixedDepositDetail,
      parentNavigatorKey: rootNavKey,
      builder: (context, state) => const BusinessFixedDepositDetailScreen(),
    )
  ],
);

final dashboardBorrowRoutes = GoRoute(
  path: RouteName.dashboardBorrow,
  builder: (context, state) => const DashboardBorrow(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualBorrow,
      builder: (context, state) => const IndividualLoanCalculationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanDocumentation,
      builder: (context, state) => const IndividualLoanDocScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualPersonalDetail,
      builder: (context, state) => const IndividualLoanPersonalDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualGuarantorDetail,
      builder: (context, state) => const IndividualGuarantorDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanApplicationPending,
      builder: (context, state) =>
          const IndividualLoanApplicationAppliedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeLoanType,
      builder: (context, state) => const IndividualLoanEmployeeTypeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanActiveDashboard,
      builder: (context, state) => const IndividualLoanActiveLoanScreen(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.pubPersonalDetails,
    //   builder: (context, state) => const PublicEmployeePersonalDetailScreen(),
    // ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.pubGuarantorDetails,
    //   builder: (context, state) => const PublicEmployeeGuarantorDetailsScreen(),
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualEmploymentDetails,
      builder: (context, state) =>
          const IndividualLoanEmploymentProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.listOfAgencies,
      builder: (context, state) =>
          const IndividualLoanPublicSectorAgenciesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.pubConnectBank,
      builder: (context, state) => const IndividualLoanConnectBankScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.pubConnectBankDetails,
      builder: (context, state) =>
          const PublicEmployeeConnectBankDetailsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.indLoanTermination,
      builder: (context, state) => const LoanTerminationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.indLoanPartPayment,
      builder: (context, state) => const LoanPartPaymentScreen(),
    ),
  ],
);

final dashboardMoreRoutes = GoRoute(
  path: RouteName.dashboardMore,
  builder: (context, state) => const DashboardMore(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.updateAccount,
      builder: (context, state) => const UpdateAccountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.editResidentialAddress,
      builder: (context, state) => const EditResidentialAddressScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterBvn,
      builder: (context, state) => const EnterBvnScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.additionalDocuments,
      builder: (context, state) => const AdditionalDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addDocument,
      builder: (context, state) => const AddDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addDocumentConfirm,
      builder: (context, state) => const AddDocumentsConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.nextOfKin,
      builder: (context, state) => const NextOfKinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.nextOfKinConfirmed,
      builder: (context, state) => const NextOfKinConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.securityQuestion,
      builder: (context, state) => const SecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.securityQuestionConfirm,
      builder: (context, state) => const SecurityQuestionConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.changepassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.changePasswordConfirm,
      builder: (context, state) => const ChangePasswordConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterOldPin,
      builder: (context, state) => const EnterOldPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterNewPin,
      builder: (context, state) => const EnterNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.confirmNewPin,
      builder: (context, state) => const ConfirmNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.newPinChange,
      builder: (context, state) => const NewPinChangedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.initiateResetPin,
      builder: (context, state) => const ResetTransactionPinOtpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.requestPos,
      builder: (context, state) => const IndividualRequestPosScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.resetTransactionPin,
      builder: (context, state) => const NewTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.personalInfo,
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.personalProfile,
      builder: (context, state) => const PersonalProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.support,
      builder: (context, state) => const CustomerSupportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.legal,
      builder: (context, state) => const LegalsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.faq,
      builder: (context, state) => const FAQScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.securityQuestionPin,
      builder: (context, state) => const EnterTransactionPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.setupBiometric,
      builder: (context, state) => const BusinessSetupBiometricScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.withdrawalLimit,
      builder: (context, state) => BusinessSetupWithdrawalLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualReferral,
      builder: (context, state) => const IndividualReferralScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualDisputes,
      builder: (context, state) => const IndividualDisputesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.indRequestStatement,
      builder: (context, state) => const IndividualRequestStatementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.indChatScreen,
      builder: (context, state) => const IndividualChatScreen(),
    ),
  ],
);

final dashboardMoreBusinessRoutes = GoRoute(
  path: RouteName.dashboardMoreBusiness,
  builder: (context, state) => const DashboardBusinessMore(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.updateAccount,
      builder: (context, state) => const UpdateAccountScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessProfile,
      builder: (context, state) => const BusinessProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterBvn,
      builder: (context, state) => const EnterBvnScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addDocument,
      builder: (context, state) => const AddDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addDocumentConfirm,
      builder: (context, state) => const AddDocumentsConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.nextOfKin,
      builder: (context, state) => const NextOfKinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.nextOfKinConfirmed,
      builder: (context, state) => const NextOfKinConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.securityQuestion,
      builder: (context, state) => const SecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.securityQuestionConfirm,
      builder: (context, state) => const SecurityQuestionConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.changepassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.initiateResetPin,
      builder: (context, state) => const ResetTransactionPinOtpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.changePasswordConfirm,
      builder: (context, state) => const ChangePasswordConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.editResidentialAddress,
      builder: (context, state) => const EditResidentialAddressScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterOldPin,
      builder: (context, state) => const EnterOldPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterNewPin,
      builder: (context, state) => const EnterNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.confirmNewPin,
      builder: (context, state) => const ConfirmNewPinScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.newPinChange,
      builder: (context, state) => const NewPinChangedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.personalInfo,
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.support,
      builder: (context, state) => const CustomerSupportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.auditLogs,
      builder: (context, state) => const AuditLogsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.auditLogDetail,
      builder: (context, state) => const AuditLogDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cards,
      builder: (context, state) => const NewCardsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.requestCards,
      builder: (context, state) => const RequestCardForm(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardRequestSummary,
      builder: (context, state) => const CardRequestSummary(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.resetCardPin,
      builder: (context, state) => const ResetCardPin(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.createCardPin,
      builder: (context, state) => const CardCreatePin(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardTransactionLimit,
      builder: (context, state) => const CardTransactionLimit(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardReplacementPage,
      builder: (context, state) => const CardReplacementPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardsDelivery,
      builder: (context, state) => const CardsDeliveryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardsDeliveryConfirm,
      builder: (context, state) => const CardsDeliveryConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardsSpendLimit,
      builder: (context, state) => const CardsSpendLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.cardsTracking,
      builder: (context, state) => const CardsTrackScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.virtualCardApply,
      builder: (context, state) => const VirtualCardApplicationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.referral,
      builder: (context, state) => const BusinessReferralScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.termsAndConditions,
      builder: (context, state) => const BusinessTermsAndConditionsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.buisnessFaq,
      builder: (context, state) => const BusinessFAQScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.enterBusinessRepresentative,
      builder: (context, state) => const BusinessRepresentativeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessInfo,
      builder: (context, state) => const BusinessInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.editBusinessInfo,
      builder: (context, state) => const EditBusinessInfoScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addBusinessDirector,
      builder: (context, state) => const BusinessDirectorDetailsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessKycDocuments,
      builder: (context, state) => const BusinessKycDocuments(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.uploadDocumentsPage,
    //   builder: (context, state){
    //     var initPage = (state.extra ?? 0) as int;
    //    return const UploadDocumentWidget();
    //    var initPage = (state.extra ?? 0) as int;
    //    return DashboardIndividualSaveScreen(initPage: initPage);
    //   },
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.setupBiometric,
      builder: (context, state) => const BusinessSetupBiometricScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessSecurityQuestionPin,
      builder: (context, state) =>
          const EnterTransactionPinSecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessSecurityQuestion,
      builder: (context, state) => const BusinessSecurityQuestionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.withdrawalLimit,
      builder: (context, state) => BusinessSetupWithdrawalLimitScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.requestPos,
      builder: (context, state) => const RequestPosScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.directorsIdVerification,
      builder: (context, state) => const DirectorIDVerificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.requestPosUtilityBill,
      builder: (context, state) => const RequestPosUtilityBillScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.requestPosCACDocument,
      builder: (context, state) => const RequestPosCACDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessUserManagement,
      builder: (context, state) => const BusinessUserManagementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessCreateRole,
      builder: (context, state) => const BusinessCreateRoleScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessViewUsers,
      builder: (context, state) => const BusinessViewUsersScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessAddUser,
      builder: (context, state) => const BusinessAddUserScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.addDirectorForm,
      builder: (context, state) => const AddDirectorForm(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizRequestStatement,
      builder: (context, state) => const BusinessRequestStatementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.bizChatScreen,
      builder: (context, state) => const BusinessChatScreen(),
    ),
  ],
);

final dashboardSpendBusinessRoutes = GoRoute(
  path: RouteName.dashboardSpendBusiness,
  builder: (context, state) => const DashboardSpendBusiness(),
  routes: const <RouteBase>[],
);

final dashboardBorrowBusinessRoutes = GoRoute(
  path: RouteName.dashboardBorrowBusiness,
  builder: (context, state) => const DashboardBorrowBusiness(),
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessLoanApply,
      builder: (context, state) => const BusinessLoanApplicationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessLoanSubmit,
      builder: (context, state) => const BusinessLoanSubmissionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessDocuments,
      builder: (context, state) => const BusinessDocumentsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessIdVerify,
      builder: (context, state) => const BusinessIdVerifyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessBankStatement,
      builder: (context, state) => const BusinessBankStatementScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.businessBankStatementConfirm,
      builder: (context, state) => const BusinessBankStatementConfirmScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.agentLoanDashboard,
      builder: (context, state) => const AgentLoanDashboard(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.agentLoanRecommended,
      builder: (context, state) => const AgentLoanRecommendedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.agentLoanRequest,
      builder: (context, state) => const AgentLoanRequestScreen(),
    ),

    ///
    /// Based on the current available loan products
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualBorrow,
      builder: (context, state) => const BusinessLoanCalculationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanDocumentation,
      builder: (context, state) => const IndividualLoanDocScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualPersonalDetail,
      builder: (context, state) => const IndividualLoanPersonalDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualGuarantorDetail,
      builder: (context, state) => const IndividualGuarantorDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanApplicationPending,
      builder: (context, state) =>
          const IndividualLoanApplicationAppliedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualBorrow,
      builder: (context, state) => const IndividualLoanCalculationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanDocumentation,
      builder: (context, state) => const IndividualLoanDocScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualPersonalDetail,
      builder: (context, state) => const IndividualLoanPersonalDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualGuarantorDetail,
      builder: (context, state) => const IndividualGuarantorDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanApplicationPending,
      builder: (context, state) =>
          const IndividualLoanApplicationAppliedScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.employeeLoanType,
      builder: (context, state) => const IndividualLoanEmployeeTypeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualLoanActiveDashboard,
      builder: (context, state) => const IndividualLoanActiveLoanScreen(),
    ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.pubPersonalDetails,
    //   builder: (context, state) => const PublicEmployeePersonalDetailScreen(),
    // ),
    // GoRoute(
    //   parentNavigatorKey: rootNavKey,
    //   path: RouteName.pubGuarantorDetails,
    //   builder: (context, state) => const PublicEmployeeGuarantorDetailsScreen(),
    // ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.individualEmploymentDetails,
      builder: (context, state) =>
          const IndividualLoanEmploymentProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.listOfAgencies,
      builder: (context, state) =>
          const IndividualLoanPublicSectorAgenciesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.pubConnectBank,
      builder: (context, state) => const IndividualLoanConnectBankScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavKey,
      path: RouteName.pubConnectBankDetails,
      builder: (context, state) =>
          const PublicEmployeeConnectBankDetailsScreen(),
    ),
  ],
);
