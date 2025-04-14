import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:movieshub/modules/poc/profile/profile_controller.dart';

import '../../../config/config.dart';
import '../ebook/ebook_controller.dart';

class TimetableScreen extends StatelessWidget {
  TimetableScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    String bgAssetPath = Assets.images.blueBg.path;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) {
            // The system or navigator already handled the pop
            return;
          }
          Get.back();
        },
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgAssetPath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColor.blue, AppColor.blueDark],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0),
                      ),
                    ),
                  ),
                  Gap(32),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(top: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.listDays.length,
                              itemBuilder: (context, index) {
                                final item = controller.listDays[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.selectedDay.value == item) {
                                      controller.selectedDay.value = item;
                                    } else {
                                      controller.selectedDay.value = item;
                                      controller.updatePeriods(item);
                                    }
                                  },
                                  child: Obx(() {
                                    var isSelected =
                                        controller.listDays[index] ==
                                            controller.selectedDay.value;
                                    return Container(
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            isSelected ? null : AppColor.white,
                                        gradient: isSelected
                                            ? const LinearGradient(
                                                colors: [
                                                  AppColor.blue,
                                                  AppColor.blueDark
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  AppColor.transparent,
                                                  AppColor.transparent
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColor.transparent
                                              : AppColor.transparent,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? AppColor.white
                                                  : AppColor.mattBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          }), // Your existing ChipList widget
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (controller.listPeriods.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 16, bottom: 60),
                        color: AppColor.transparent,
                        height: Get.height * 0.6,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.listPeriods.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 48),
                            itemBuilder: (context, index) {
                              final item = controller.listPeriods[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 64,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColor.white.withOpacity(0.5),
                                  ),
                                  child: BlurryContainer(
                                    elevation: 2,
                                    color: AppColor.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                    blur: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 16),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    Assets.images.dummy.path),
                                                height: 40,
                                                width: 40,
                                              )),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 4),
                                              child: Text(
                                                item,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      FontFamily.poppins,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.textColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 16, top: 2),
                                              child: Text(
                                                controller.subjectTeacherMap[
                                                        item] ??
                                                    'Anita Sharma',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      FontFamily.poppins,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.subtitleColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, top: 4, right: 16),
                                              child: Text(
                                                '8:00 - 8:45',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      FontFamily.poppins,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.subtitleColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, top: 4, right: 16),
                                              child: Text(
                                                (index % 2 == 0)
                                                    ? 'Theory'
                                                    : 'Practical',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      FontFamily.poppins,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.subtitleColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16, top: 32),
                  child: Text(
                    "Timetable",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.poppins,
                        letterSpacing: 0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              top: Get.height * 0.11,
              left: 0,
              right: 0,
              child: Container(
                height: 48,
                width: double.infinity,
                margin: EdgeInsets.only(top: 4, left: 24, right: 24),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dotGray.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Center(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Class 12th: Science",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
