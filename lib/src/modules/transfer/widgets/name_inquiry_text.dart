import 'package:flutter/material.dart';

class NameInquiryText extends StatelessWidget {
  const NameInquiryText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 14, bottom: 4, right: 14),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffD0DEFF),
        ),
        child: Text(text),
      ),
    );
  }
}
