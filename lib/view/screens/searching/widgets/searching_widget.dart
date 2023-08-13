import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/view/base/ripple/ripple.dart';

class SearchingWidget extends StatelessWidget {
  const SearchingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Center(
            child: RipplesAnimation(
          color: Theme.of(context).primaryColor,
          child: const Icon(
            Iconsax.location,
            color: Colors.white,
          ),
        )),
        const SizedBox(height: 20),
        Text(
          'Searching for a driver',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
