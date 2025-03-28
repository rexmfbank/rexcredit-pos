import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class NextPaymentCardLayout extends StatelessWidget {
  final String nextExpectedDate;
  final String nextExpectedInDays;
  final bool autoSave;
  final ValueChanged<bool>? onAutosaveToggle;

  const NextPaymentCardLayout({
    super.key,
    required this.nextExpectedDate,
    required this.nextExpectedInDays,
    required this.autoSave,
    this.onAutosaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    List<String> nextSavingsDateInWord = nextExpectedDate.split(" ");
    String nextSavingsDateDay = nextSavingsDateInWord[0];
    String nextSavingsDateMonth =
        nextSavingsDateInWord[nextSavingsDateInWord.length - 1];
    String nextExpectedInDaysFormatted = nextExpectedInDays.contains('ago')
        ? "was $nextExpectedInDays"
        : "is $nextExpectedInDays";
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                          nextSavingsDateMonth,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: AppColors.rexTint700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 4.0),
                        child: Text(
                          nextSavingsDateDay,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Center(
                      child: Flexible(
                        child: Text(
                          "Next expected deposit $nextExpectedInDaysFormatted",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(0.5),
              height: 20.0,
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    "Turn on auto-save",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Switch(
                    value: autoSave,
                    onChanged: onAutosaveToggle,
                  ),
                ),
              ],
            ),
            autoSave
                ? Divider(
                    color: Colors.grey.withOpacity(0.5),
                    height: 20.0,
                    thickness: 0.5,
                  )
                : Container(),
            autoSave
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 22.0),
                        child: Image.asset("assets/png/visa_icon.png"),
                      ),
                      const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 22.0),
                            child: Text(
                              "**** **** **** 1234",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 4.0),
                            child: Text(
                              "Expires 01/22",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
