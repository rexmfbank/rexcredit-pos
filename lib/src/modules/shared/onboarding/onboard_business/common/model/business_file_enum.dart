// ignore_for_file: constant_identifier_names

enum BusinessFileEnum {
  CAC_CERTIFICATE_REGISTRATION(
    title: 'CAC_Certificate_Of_Registration',
    shortName: 'cacCert',
    tag: 'Upload CAC Certificate of Registration',
  ),
  CAC_REGISTRATION_APPLICATION(
    title: 'CAC_Application_For_Registration',
    shortName: 'cacApply',
    tag: 'Upload CAC Application for Registration',
  ),
  UTILITY_BILL(
    title: 'Utility_Bill',
    shortName: 'utility',
    tag: 'Upload Utility Bill',
  ),
  MEMORANDUM_OF_ASSOCIATION(
    title: 'Memorandum_And_Article_Of_Association',
    shortName: 'memorandum',
    tag: 'Upload Memorandum and Article of Association',
  ),
  FORM_Co7(
    title: 'Form_Co7_Particulars_Of_Directors',
    shortName: 'formCo7',
    tag: 'Upload Form Co7 - Particulars of Directors',
  ),
  FORM_Co2(
    title: 'Form_Co2_Allotment_Of_Shares',
    shortName: 'formCo2',
    tag: 'Upload Form Co2 - Allotment of Shares',
  ),
  BOARD_RESOLUTION(
    title: 'Board_Resolution',
    shortName: 'resBoard',
    tag: 'Upload Board Resolution',
  ),
  CERTIFICATE_OF_REGISTRATION(
    title: 'Certificate_Of_Registration',
    shortName: 'certRegister',
    tag: 'Upload Certificate of Registration',
  ),
  COPY_OF_CONSTITUTION(
    title: 'Copy_Of_Constitution',
    shortName: 'constitution',
    tag: 'Upload Copy of Constitution',
  ),
  PARTNERSHIP_DEED(
    title: 'Partnership_Deed',
    shortName: 'deed',
    tag: 'Upload Partnership Deed',
  ),
  RESOLUTION_ACCOUNT_OPENING(
    title: 'Resolution_For_Account_Opening',
    shortName: 'resAccount',
    tag: 'Upload Resolution for Account Opening',
  );

  final String title;
  final String shortName;
  final String tag;

  const BusinessFileEnum({
    required this.title,
    required this.shortName,
    required this.tag,
  });
}

enum BusinessFileStatus {
  fileIsNull,
  fileIsNotNull,
  fileIsUploading,
  fileIsUploaded,
  fileUploadError,
}
