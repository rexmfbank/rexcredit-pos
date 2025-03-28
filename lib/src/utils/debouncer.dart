import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int delay;
  Timer? _timer;

  Debouncer({required this.delay});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: delay), action);
  }

  void dispose() {
    _timer?.cancel(); // You can comment-out this line if you want. I am not sure if this call brings any value.
    _timer = null;
  }
}