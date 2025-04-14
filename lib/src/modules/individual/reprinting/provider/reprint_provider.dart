import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/reprinting/model/reprint_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

final reprintProvider = NotifierProvider<ReprintNotifier, ReprintState>(
  ReprintNotifier.new,
);

class ReprintNotifier extends Notifier<ReprintState> {
  @override
  ReprintState build() {
    return ReprintState(
      todaysDate: DateTime.now().dateYYYYMMDD(),
    );
  }

  
}
