import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class ShippingAddress extends StatelessWidget {
  final String title;
  final String placeName;
  final String subTitle;
  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  const ShippingAddress({
    super.key,
    required this.title,
    required this.subTitle,
    required this.placeName,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Appcolor.deepPink : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: isSelected ? Appcolor.deepPink : Colors.grey.shade300,
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: placeName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: subTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              trailing: Radio(
                value: isSelected,
                groupValue: true,
                onChanged: (value) {},
                activeColor: Appcolor.deepPink,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
