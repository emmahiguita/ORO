import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/constant/color.dart';

class SelectImage extends StatelessWidget {
  final dynamic controller;
  final bool isEdit;
  const SelectImage({
    super.key,
    required this.controller,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Category Image',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        if (controller.image != null) ...[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.file(
                controller.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Change Image'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Appcolor.pink),
            ),
            onPressed: () async {
              await controller.getImage();
            },
          ),
        ] else ...[
          Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[50],
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Appcolor.berry.withValues(alpha: 0.2),
              onTap: () async {
                await controller.getImage();
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isEdit
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.network(
                            AppLink.categoriesimage +
                                controller.categoriesModel!.categoryImg!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Tap to edit category image',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Tap to add category image',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ]),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
