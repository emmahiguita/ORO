import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/AddressLine.dart';

class AddressInfoCard extends StatelessWidget {
  final String? addressName;
  final String? building;
  final String? apartment;
  final String? floor;
  final String? street;
  final String? block;
  final String? way;
  const AddressInfoCard(
      {super.key,
      this.addressName,
      this.building,
      this.apartment,
      this.floor,
      this.street,
      this.block,
      this.way});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Appcolor.berry, size: 20),
              SizedBox(width: 8),
              Text(
                'Dirección de entrega',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.berry,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (addressName?.isNotEmpty ?? false)
            AddressLinee(icon: Icons.person_outline, text: addressName!),
          if (building?.isNotEmpty ?? false)
            AddressLinee(
                icon: Icons.home_work_outlined, text: 'Building $building'),
          if (apartment?.isNotEmpty ?? false)
            AddressLinee(
                icon: Icons.door_front_door_outlined,
                text: 'Apartment $apartment'),
          if (floor?.isNotEmpty ?? false)
            AddressLinee(icon: Icons.stairs_outlined, text: 'Floor $floor'),
          if (street?.isNotEmpty ?? false)
            AddressLinee(icon: Icons.roundabout_left, text: street!),
          if (block?.isNotEmpty ?? false)
            AddressLinee(icon: Icons.grid_view_outlined, text: 'Block $block'),
          if (way?.isNotEmpty ?? false)
            AddressLinee(icon: Icons.directions_outlined, text: way!),
        ],
      ),
    );
  }
}
