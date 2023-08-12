import 'package:flutter/material.dart';
import 'package:taxi_user/utils/style.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  const QuantityWidget(
      {required this.quantity, required this.onQuantityChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: [
          InkWell(
            child: Icon(
              Icons.remove,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (quantity > 1) {
                onQuantityChanged(quantity - 1);
              }
            },
          ),
          const SizedBox(width: 15),
          Text(
            '$quantity',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 15),
          InkWell(
            child: Icon(
              Icons.add,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (quantity > 1) {
                onQuantityChanged(quantity + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}
