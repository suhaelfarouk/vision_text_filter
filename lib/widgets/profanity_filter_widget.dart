import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profanity_filter_provider.dart';

class ProfanityFilterWidget extends StatelessWidget {
  ProfanityFilterWidget({super.key});

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profanityFilterProvider = context.watch<ProfanityFilterProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            onChanged: (text) {
              profanityFilterProvider.checkProfanity(text);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              labelText: 'Type a message',
              errorText: profanityFilterProvider.isProfane
                  ? 'Profanity detected'
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
