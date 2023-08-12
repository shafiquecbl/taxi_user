import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';

class CountryCodePicker extends StatefulWidget {
  final void Function(Country) onSelect;
  const CountryCodePicker({required this.onSelect, super.key});

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  String countryCode = '+92';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          favorite: ['+92'],
          countryListTheme: CountryListThemeData(
              searchTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          onSelect: (Country country) {
            setState(() {
              countryCode = "+${country.phoneCode}";
            });
            widget.onSelect(country);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: AppConstants.isOutline ? null : Theme.of(context).cardColor,
          border: AppConstants.isOutline
              ? Border.all(color: Theme.of(context).primaryColor)
              : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          children: [
            Text(countryCode,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).hintColor)),
            const SizedBox(width: 5),
            const Icon(FFIcons.downArrow, color: Colors.grey, size: 15),
          ],
        ),
      ),
    );
  }
}
