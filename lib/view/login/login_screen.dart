import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/global_app_bar.dart';
import '../../global/widget/global_button.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_textform_field.dart';
import '../../global/widget/songs_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const GlobalAppBar(title: "Login"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GlobalContainer(
                backgroundColor: ColorRes.backgroundColor,
                width: Get.width,
                child: GlobalTextFormField(
                  controller: phoneController,
                  titleText: 'Phone',
                  hintText: 'Enter Your Phone Number',
                  isDense: true,
                  maxLine: 1,
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              GlobalTextFormField(
                controller: passwordController,
                titleText: 'Password',
                hintText: 'Enter Your Password',
                isDense: true,
                maxLine: 1,
                filled: true,
              ),
              const SizedBox(height: 20),
              GlobalButtonWidget(
                str: 'Login',
                height: 45,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
