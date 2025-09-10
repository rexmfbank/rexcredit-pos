import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class RexApi
    with
        GetState,
        GetLocalGovt,
        VerifyOtp,
        VerifyNewDevice,
        UpdateUser,
        SetTransactionPin,
        SelfPasswordReset,
        Login,
        ChangePin,
        ChangeTransactionPin,
        ResendOtp,
        InitiatePasswordReset,
        AddNextOfKin,
        GetNextOfKin,
        FetchLookupData,
        InternalTransfer,
        AccountLookUp,
        InternalTSQ,
        InternalBalanceEnquiry,
        GetAllCategoryCode,
        ListLookupData,
        AppCountries,
        TransferApi,
        ContactCare,
        TermsConditionsAndPolicy,
        ViewSecurityQuestion,
        StoreSecurityQuestion,
        MiniStatement,
        AccountTopUp,
        BillPaymentApi,
        UpdateAddress,
        TransactionDisputeApi,
        DeactivateAccount,
        GetProfileInfo,
        SaveBeneficiary,
        FetchBeneficiaries,
        ResetTransactionPin,
        BankStatement,
        Setup,
        PosApi {
  RexApi._();

  static final RexApi _instance = RexApi._();

  static RexApi get instance => _instance;
}
