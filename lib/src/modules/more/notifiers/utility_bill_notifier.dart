import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/more/models/document_type.dart';

class UtilityBillNotifier extends Notifier<DocumentType> {
  @override
  DocumentType build() {
    return const DocumentType.empty();
  }

  void onDropdownChange(DocumentType? value) {
    state = value!;
  }
}
