import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:movieshub/modules/login/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  final scrollController = ScrollController();
  final hasFocus = false.obs;
  final hasFocus2 = false.obs;

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {

    bool isKeyBoardOpen = (MediaQuery.of(context).viewInsets.bottom == 0) ? false : true;

    var _obscureText = true.obs;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        // Get.back();
      },
      child: Scaffold(
          backgroundColor: AppColor.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.transparent,
                  image: DecorationImage(
                    image: AssetImage(Assets.images.blueBg.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Obx(() {
                                if (controller.connection.value) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: Text(
                                            "Sign in",
                                            style: const TextStyle(
                                                fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColor.bluePrimary),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16, top: 32, right: 16),
                                        child: const Center(
                                          child: Text(
                                            "Take the First Step\nto a Better Life.",
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: FontFamily.poppins,
                                                color: AppColor.titleColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                                        child: const Center(
                                          child: Text(
                                            '"The best way to predict your future is to create it." – Abraham Lincoln',
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.poppins,
                                                color: AppColor.subtitleColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Obx(() {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            boxShadow: hasFocus.value
                                                ? [
                                              const BoxShadow(
                                                  blurRadius: 0,
                                                  spreadRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: AppColor.shadowBlueOutline,
                                                  blurStyle: BlurStyle.normal),
                                            ]
                                                : null,
                                          ),
                                          child: TextField(
                                            controller: controller.emailController,
                                            style: const TextStyle(
                                                color: AppColor.black,
                                                fontFamily: FontFamily.poppins,
                                                fontSize: 15
                                            ),
                                            maxLength: 30,
                                            onTap: () {
                                              hasFocus.value = true;
                                              hasFocus2.value = false;
                                            },
                                            onTapOutside: (p) {
                                              hasFocus.value = false;
                                              hasFocus2.value = false;
                                              FocusScope.of(context).unfocus();
                                            },
                                            onChanged: (p) {
                                              // controller.emailIdForOtp.value = p;
                                              controller.email.value = p;
                                              if (p.isNotEmpty) {
                                                if (controller.validateEmail(p)) {
                                                  controller.validEmail.value = true;
                                                } else {
                                                  controller.validEmail.value = false;
                                                }
                                              } else {
                                                controller.validEmail.value = false;
                                              }
                                            },
                                            autocorrect: false,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: AppColor.white,
                                              hintText: 'Enter your email',
                                              counterText: "",
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.blueLight),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              hintStyle: TextStyle(
                                                color: AppColor.subtitleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.poppins,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Gap(8),
                                      Obx(() {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            boxShadow: hasFocus2.value
                                                ? [
                                              const BoxShadow(
                                                  blurRadius: 0,
                                                  spreadRadius: 2,
                                                  offset: Offset(0, 0),
                                                  color: AppColor.shadowBlueOutline,
                                                  blurStyle: BlurStyle.normal),
                                            ]
                                                : null,
                                          ),
                                          child: TextField(
                                            controller: controller.passController,
                                            style: const TextStyle(
                                                color: AppColor.black,
                                                fontFamily: FontFamily.poppins,
                                                fontSize: 15
                                            ),
                                            maxLength: 30,
                                            onTap: () {
                                              hasFocus2.value = true;
                                              hasFocus.value = false;
                                            },
                                            obscureText: _obscureText.value,
                                            onTapOutside: (p) {
                                              hasFocus2.value = false;
                                              hasFocus.value = false;
                                              FocusScope.of(context).unfocus();
                                            },
                                            onChanged: (p) {
                                              controller.pass.value = p;
                                            },
                                            autocorrect: false,

                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColor.white,
                                              hintText: 'Enter your password',
                                              counterText: "",
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              disabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.transparent),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: AppColor.blueLight),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              hintStyle: const TextStyle(
                                                color: AppColor.subtitleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: FontFamily.poppins,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscureText.value ? Icons.visibility_off : Icons.visibility,
                                                  color: AppColor.subtitleColor,
                                                ),
                                                onPressed: () {
                                                  _obscureText.value = !_obscureText.value;
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Gap(16),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                margin: const EdgeInsets.only(right: 16),
                                                height: 1,
                                                color: AppColor.viewLightMode,
                                              ),
                                            ),
                                            const Text(
                                              "Or continue in with Google",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.poppins,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 16),
                                                height: 1,
                                                color: AppColor.viewLightMode,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // controller.handleGoogleSignIn(context);
                                          Get.snackbar(
                                            'Configuration error',
                                            'Please add Google services json file',
                                            titleText: Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                'Configuration error',
                                                style: TextStyle(
                                                    color: AppColor.error,
                                                    fontFamily: FontFamily.poppins,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            messageText: Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Text(
                                                // 'explore'.tr,
                                                'Please add Google services json file',
                                                style: const TextStyle(
                                                    color: AppColor.titleColor,
                                                    fontFamily: FontFamily.poppins,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            snackPosition: SnackPosition.BOTTOM,
                                            borderRadius: 10,
                                            backgroundColor: AppColor.white,
                                            icon: Image.asset(
                                              Assets.images.noInternet.path,
                                              height: 32,
                                              width: 32,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 16),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
                                          width: double.infinity,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: AppColor.blueLight,),
                                            color: AppColor.white,
                                          ),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Image(
                                                image: AssetImage(Assets.images.google.path),
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              const Text(
                                                "Sign in with Google",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: FontFamily.poppins,
                                                    color: AppColor.titleColor),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Visibility(
                                        visible: !isKeyBoardOpen,
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 24),
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: FontFamily.poppins,
                                                    fontSize: 12,
                                                    color: AppColor.titleColor,
                                                    letterSpacing: 0.2),
                                                children: [
                                                  const TextSpan(text: "By continuing, you agree to our\n"),
                                                  TextSpan(
                                                    text: "Terms of Service",
                                                    style: const TextStyle(decoration: TextDecoration.underline),
                                                    recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(controller.tncUrl),
                                                  ),
                                                  const TextSpan(
                                                    text: " | ",
                                                  ),
                                                  TextSpan(
                                                    text: "Privacy Policy",
                                                    style: const TextStyle(decoration: TextDecoration.underline),
                                                    recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(controller.privacyUrl),
                                                  ),
                                                  const TextSpan(
                                                    text: " | ",
                                                  ),
                                                  TextSpan(
                                                    text: "Disclaimer",
                                                    style: const TextStyle(decoration: TextDecoration.underline),
                                                    recognizer: TapGestureRecognizer()..onTap = () => controller.showDisclaimerDialog(context),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // if (controller.validEmail.value && controller.emailIdForOtp.isNotEmpty) {
                                          //   FocusScope.of(context).unfocus();
                                          //   controller.onSubmit(context);
                                          // }
                                          debugPrint('email. ::  ${controller.email.value}, ${controller.pass.value}');
                                          if (controller.validEmail.value &&
                                              controller.email.value == 'admin@gmail.com' &&
                                              controller.pass.value == 'admin') {
                                            Get.toNamed(AppRoute.home);
                                            controller.setUserLogin();
                                          } else {
                                            if (controller.validEmail.value) {
                                              Get.snackbar(
                                                'Login failed',
                                                'Please enter correct credential',
                                                titleText: const Padding(
                                                  padding: EdgeInsets.only(top: 8.0),
                                                  child: Text(
                                                    'Login failed',
                                                    style: TextStyle(
                                                        color: AppColor.error,
                                                        fontFamily: FontFamily.poppins,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                messageText: const Padding(
                                                  padding: EdgeInsets.only(bottom: 8.0),
                                                  child: Text(
                                                    'Please enter correct credential',
                                                    style: TextStyle(
                                                        color: AppColor.titleColor,
                                                        fontFamily: FontFamily.poppins,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                snackPosition: SnackPosition.BOTTOM,
                                                borderRadius: 10,
                                                backgroundColor: AppColor.white,
                                                icon: Image.asset(
                                                  Assets.images.noInternet.path,
                                                  height: 32,
                                                  width: 32,
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                              );
                                            }
                                          }
                                          // isUserLogin
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          height: 54,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Obx(() {
                                              return DecoratedBox(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: (controller.validEmail.value && controller.pass.value.isNotEmpty) ? AppColor.bluePrimary : AppColor.blueLight
                                                ),
                                                child: const Material(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                                                    child: Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColor.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: FontFamily.poppins,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      MediaQuery.of(context).viewInsets.bottom == 0
                                          ? Container(height: 24)
                                          : Container(height: 96),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        const Text(
                                          'Network error',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.titleColor,
                                          ),
                                        ),
                                        const Gap(8),
                                        const Text(
                                          'Please check your internet connection.',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.titleColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Spacer(),
                                        Image(
                                          image: AssetImage(
                                            Assets.images.noInternet.path,
                                          ),
                                          height: 200,
                                          width: 250,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: (){
                                            controller.checkConnectivity();
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: AppColor.bluePrimary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                                              child: Text(
                                                "Retry",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: FontFamily.poppins,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
