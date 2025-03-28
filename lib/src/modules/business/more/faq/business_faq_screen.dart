import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/more/faqs/ui/components/faq_item_widget.dart';
import 'package:rex_app/src/modules/individual/more/faqs/providers/faq_api_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class BusinessFAQScreen extends ConsumerStatefulWidget {
  const BusinessFAQScreen({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusinessFAQScreenState();
}

class _BusinessFAQScreenState extends ConsumerState<BusinessFAQScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(faqProvider.notifier).getFrequentlyAskedQuestions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final faqItemsData = ref.watch(faqProvider);
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'FAQs',
        subtitle: 'Get answers to common questions you may have',
        hasActionButton: false,
      ),
      body: faqItemsData.when(
        data: (faqItems) {
          debugPrint("$faqItems");
          return ListView.builder(
            itemCount: faqItems.length,
            itemBuilder: (context, index) {
              final item = faqItems[index];
              return FAQItemWidget(
                question: item.name,
                answer: item.description,
              );
            },
          );
        },
        loading: () => const SizedBox.expand(
            child: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            tileColor: const Color.fromARGB(255, 136, 46, 46),
            title: Text('Error: $error')),
      ),
    );
  }
}
