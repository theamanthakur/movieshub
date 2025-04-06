import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController pageController = PageController();
  final controller = Get.put(OnboardingController());

  int _lastBackPress = 0;

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        int now = DateTime.now().millisecondsSinceEpoch;
        if (now - _lastBackPress < 2000) {
          // Exit app
          SystemNavigator.pop();
        } else {
          // Show a snackbar or a brief message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );

          _lastBackPress = now; // Update timestamp
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.transparent,
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
            SafeArea(child: Obx(() {
              if (controller.connection.value) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Gap(8),
                        const Center(
                          child: Text(
                            'MoviesHub',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.poppins,
                              fontSize: 16,
                              color: AppColor.bluePrimary,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Obx(() {
                          return Container(
                            margin: EdgeInsets.only(top: 32),
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.65,
                            ),
                            child: PageView.builder(
                                controller: pageController,
                                onPageChanged: (index) {
                                  controller.selectedIndex.value = index;
                                },
                                itemCount: controller.onboarding.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              '${controller.onboarding[index].title}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: FontFamily.poppins,
                                                fontSize: 20,
                                                color: AppColor.textColor,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Gap(16),
                                          Obx(() {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Center(
                                                child: ClipRRect( // Wrap the Image with ClipRRect
                                                  borderRadius: BorderRadius.circular(16.0), // Apply border radius of 16
                                                  child: Image(
                                                    height: MediaQuery.sizeOf(context).width * 0.8,
                                                    width: MediaQuery.sizeOf(context).width * 0.8,
                                                    image: NetworkImage("${controller.onboarding[index].image}"),
                                                    fit: BoxFit.cover, // Recommended to use BoxFit.cover for fitting within rounded bounds
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                          const Gap(32),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              '${controller.onboarding[index].description}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.poppins,
                                                fontSize: 15,
                                                color: AppColor.subtitleColor,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 4,
                                            ),
                                          ),
                                          Gap(16),
                                        ],
                                      )
                                    ],
                                  );
                                }),
                          );
                        }),
                        Obx(() {
                          return Container(
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  controller.onboarding.length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: AnimatedDot(
                                            isActive: controller
                                                    .selectedIndex.value ==
                                                index),
                                      )),
                            ),
                          );
                        }),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 124,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 32,
                                right: 32,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.poppins,
                                      fontSize: 12,
                                      color: AppColor.subtitleColor,
                                      letterSpacing: 0.2),
                                  children: [
                                    TextSpan(
                                        text:
                                            "By continuing, you agree to our\n"),
                                    TextSpan(
                                      text: "Terms of Service",
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => _launchUrl(controller.tncUrl),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            _launchUrl(controller.privacyUrl),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoute.login);
                                    controller.setOnboardingComplete();
                                  },
                                  child: SizedBox(
                                    width: 150,
                                    height: 54,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.bluePrimary),
                                          color: AppColor.white),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Skip",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor.bluePrimary,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: FontFamily.poppins,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (controller.selectedIndex ==
                                        controller.onboarding.length - 1) {
                                      Get.toNamed(AppRoute.login);
                                      controller.setOnboardingComplete();
                                    } else {
                                      pageController.animateToPage(
                                        controller.selectedIndex.value + 1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        // Adjust animation duration as needed
                                        curve: Curves
                                            .ease, // Adjust animation curve as needed
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    width: 150,
                                    height: 54,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.bluePrimary),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Next",
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
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                          ],
                        ),
                      ),
                    ),
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
                        onTap: () {
                          controller.checkConnectivity();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColor.bluePrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 16),
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
            })),
          ],
        ),
      ),
    );
  }
}

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColor.bluePrimary : AppColor.blueLight,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
