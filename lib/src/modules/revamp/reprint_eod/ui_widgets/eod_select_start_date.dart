import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/reprint_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EODDateStart extends ConsumerStatefulWidget {
  const EODDateStart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EODDateStartState();
}

class _EODDateStartState extends ConsumerState<EODDateStart> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Select start date',
    );
    if (picked != null) {
      _controller.text = formatEODdate(picked);
      setState(() {});
      ref.read(reprintProvider.notifier).setTodaysDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6.ah),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F8FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Start Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _controller.text.isEmpty ? 'DD/MM/YY' : _controller.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_month_outlined,
              size: 32,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}

String formatEODdate(DateTime date) {
  final day = date.day.toString().padLeft(2, "0");
  final month = date.month.toString().padLeft(2, "0");
  final year = date.year.toString().substring(2);
  return '$day/$month/$year';
}
