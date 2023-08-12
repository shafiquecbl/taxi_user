import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/controller/localization_controller.dart';
import 'package:taxi_user/data/model/language.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('select_language'.tr),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: GetBuilder<LocalizationController>(
                    builder: (con) {
                      return ListView.builder(
                        itemCount: con.languages.length,
                        itemBuilder: (context, index) {
                          LanguageModel language =
                              AppConstants.languages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(radius),
                              onTap: () {
                                con.setSelectIndex(index);
                                // set language
                                LocalizationController.to.setLanguage(Locale(
                                    language.languageCode,
                                    language.countryCode));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: con.selectedIndex == index
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2)
                                      : null,
                                  border: Border.all(
                                    color: Theme.of(context).cardColor,
                                  ),
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      language.imageUrl,
                                      height: 35,
                                      width: 35,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(language.languageName)),
                                    const Spacer(),
                                    con.selectedIndex == index
                                        ? const CustomIcon(
                                            icon: FFIcons.tick,
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'done'.tr,
                  onPressed: Get.back,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
