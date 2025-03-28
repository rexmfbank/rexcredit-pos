import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final loggerProvider = Provider<Logger>((ref) => Logger());

final selectedCountryProvider = StateProvider<String>((ref) => 'Nigeria');
