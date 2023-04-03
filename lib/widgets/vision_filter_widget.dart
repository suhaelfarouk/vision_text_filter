import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_text_filter/providers/vision_filter_provider.dart';

class VisionFilterWidget extends StatelessWidget {
  const VisionFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visionFilterProvider = context.watch<VisionFilterProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: visionFilterProvider.pickImage,
            child: const Text('Select Image'),
          ),
          if (visionFilterProvider.imageFile != null)
            const Text('Image Selected'),
          if (visionFilterProvider.uploadedImageUrl != null &&
              visionFilterProvider.visionFilterModel != null)
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(visionFilterProvider.uploadedImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: visionFilterProvider
                                      .visionFilterModel!
                                      .responses[0]
                                      .safeSearchAnnotation
                                      .adult ==
                                  'VERY_LIKELY' ||
                              visionFilterProvider
                                      .visionFilterModel!
                                      .responses[0]
                                      .safeSearchAnnotation
                                      .adult ==
                                  'LIKELY'
                          ? 10
                          : 0,
                      sigmaY: visionFilterProvider
                                      .visionFilterModel!
                                      .responses[0]
                                      .safeSearchAnnotation
                                      .adult ==
                                  'LIKELY' ||
                              visionFilterProvider
                                      .visionFilterModel!
                                      .responses[0]
                                      .safeSearchAnnotation
                                      .adult ==
                                  'VERY_LIKELY'
                          ? 10
                          : 0),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          if (visionFilterProvider.imageFile != null)
            ElevatedButton(
              onPressed: visionFilterProvider.uploadImage,
              child: const Text('Check Image'),
            ),
          if (visionFilterProvider.visionFilterModel != null)
            Text(
                'Adult: ${visionFilterProvider.visionFilterModel!.responses[0].safeSearchAnnotation.adult}'),
        ],
      ),
    );
  }
}
