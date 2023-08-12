import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActionButtons extends StatelessWidget {
  final Function()? onEdit;
  final Function()? onDelete;
  const ActionButtons({this.onDelete, this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Wrap(
        spacing: 8,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blue),
              ),
              child: const Icon(
                Iconsax.edit,
                size: 18,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: const Icon(
                Iconsax.trash,
                size: 18,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
