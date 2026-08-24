import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class AddressInfoCard extends StatelessWidget {
  final String? addressName;
  final String? building;
  final String? apartment;
  final String? floor;
  final String? street;
  final String? block;
  final String? way;

  const AddressInfoCard({
    super.key,
    this.addressName,
    this.building,
    this.apartment,
    this.floor,
    this.street,
    this.block,
    this.way,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 251, 249, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dirección de entrega',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (addressName?.isNotEmpty ?? false)
            _buildAddressLine(Icons.person_outline, addressName!),
          if (building?.isNotEmpty ?? false)
            _buildAddressLine(Icons.home_work_outlined, 'Building $building'),
          if (apartment?.isNotEmpty ?? false)
            _buildAddressLine(
                Icons.door_front_door_outlined, 'Apartment $apartment'),
          if (floor?.isNotEmpty ?? false)
            _buildAddressLine(Icons.stairs_outlined, 'Floor $floor'),
          if (street?.isNotEmpty ?? false)
            _buildAddressLine(Icons.roundabout_left, street!),
          if (block?.isNotEmpty ?? false)
            _buildAddressLine(Icons.grid_view_outlined, 'Block $block'),
          if (way?.isNotEmpty ?? false)
            _buildAddressLine(Icons.directions_outlined, way!),
        ],
      ),
    );
  }

  Widget _buildAddressLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Appcolor.berry,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
