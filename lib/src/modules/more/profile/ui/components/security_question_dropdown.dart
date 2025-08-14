/*class SecurityQuestionDropdown extends ConsumerWidget {
  final EdgeInsets? padding;
  const SecurityQuestionDropdown({super.key, this.padding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionList = ref.watch(securityQuestionListProvider);
    //
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.aw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            StringAssets.selectSecurityQuestion,
            style: AppTextStyles.h2.copyWith(color: AppColors.rexPurpleDark),
          ),
          SizedBox(height: 10.ah),
          Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: questionList.when(
              data: (data) {
                return DropdownButtonFormField(
                  items:
                      data.map<
                        DropdownMenuItem<FetchLookupDataByCodeResponseData>
                      >((question) {
                        return DropdownMenuItem(
                          value: question,
                          child: Text(question.name),
                        );
                      }).toList(),
                  onChanged: (FetchLookupDataByCodeResponseData? value) {
                    ref
                        .read(securityQuestionScreenProvider.notifier)
                        .onDropdownChange(value);
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: rexInputBorder,
                    enabledBorder: rexInputBorder,
                    focusedBorder: rexInputBorder,
                  ),
                  isExpanded: true,
                );
              },
              error: (obj, stack) => const RexDisabledDropdown(),
              loading: () => const RexDisabledDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}*/
