import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/config.dart';

class BannerCarousel extends StatelessWidget {
  var bannerList = RxList<String>();
  final bannerSelectedIndex = 0.obs;
  final pageController = PageController(initialPage: 0, keepPage: false);
  Timer? _timer;

  BannerCarousel({
    required this.bannerList,
  });


  @override
  Widget build(BuildContext context) {
    timerBanner();

    return Container(
      height: 200,
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Obx(() {
        return Column(
          children: [
            SizedBox(
              height: 170,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) => bannerSelectedIndex.value = index,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  final item = bannerList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image(image: AssetImage(item), fit: BoxFit.fill,),
                    ),
                  );
                },
              ),
            ),
            Obx(() {
              return Container(
                margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AnimatedDot(
                        isActive: bannerSelectedIndex.value == index,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      }),
    );
  }

  void timerBanner() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _handleAutoChange();
    });
  }

  void _handleAutoChange() {
    if (bannerList.isNotEmpty && pageController.hasClients) {
      bannerSelectedIndex.value = (bannerSelectedIndex.value + 1) % bannerList.length;
      pageController.animateToPage(
        bannerSelectedIndex.value,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
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
        color: isActive ? AppColor.bluePrimary : AppColor.gray.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
