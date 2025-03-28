import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/more/models/document_type.dart';
import 'package:rex_app/src/modules/individual/more/notifiers/id_card_notifier.dart';
import 'package:rex_app/src/modules/individual/more/notifiers/utility_bill_notifier.dart';

final idCardProvider = NotifierProvider<IdCardNotifier, DocumentType>(
  () => IdCardNotifier(),
);

final utilityBillProvider = NotifierProvider<UtilityBillNotifier, DocumentType>(
  () => UtilityBillNotifier(),
);
