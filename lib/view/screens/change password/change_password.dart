import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/common/textfield.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';

class ChanegPasswordScreen extends StatefulWidget {
  const ChanegPasswordScreen({super.key});

  @override
  State<ChanegPasswordScreen> createState() => _ChanegPasswordScreenState();
}

class _ChanegPasswordScreenState extends State<ChanegPasswordScreen> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: 'Old Password ',
                hintText: 'Enter Old Password',
                prefixIcon: FFIcons.lock,
                controller: name,
              ),

              // email textfield
              CustomTextField(
                labelText: 'New Password',
                hintText: 'Enter New Password',
                prefixIcon: FFIcons.lock,
                controller: name,
              ),

              // dob textfield
              CustomTextField(
                labelText: 'Confirm Password',
                hintText: 'Enter password again',
                prefixIcon: FFIcons.lock,
                controller: name,
              ),

              SizedBox(height: getPixels(context, 50)),
              // save button
              PrimaryButton(
                text: 'Update Password',
                onPressed: () {},
                options: ButtonOptions(
                    color: Theme.of(context).primaryColor,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
