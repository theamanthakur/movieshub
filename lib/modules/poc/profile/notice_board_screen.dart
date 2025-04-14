import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:movieshub/modules/poc/profile/profile_controller.dart';

import '../../../config/config.dart';

class NoticeBoardScreen extends StatelessWidget {
  NoticeBoardScreen({super.key});

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
                                itemCount: controller.noticeList.length,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 48),
                                itemBuilder: (context, index) {
                                  final item = controller.noticeList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoute.timetable,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                                      height: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: AppColor.white.withOpacity(0.5),
                                      ),
                                      child: BlurryContainer(
                                        width:
                                        MediaQuery.of(context).size.width * 0.8,
                                        height: 130,
                                        elevation: 2,
                                        color: AppColor.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                        blur: 1,
                                        child: Row(
                                          children: [
                                            Gap(4),
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                              // Apply borderRadius to all corners
                                              child: Image(
                                                image: NetworkImage(
                                                    item.fileUrl),
                                                fit: BoxFit.cover,
                                                // Use BoxFit.cover to fill the bounds
                                                height: 100,
                                                width: 88,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8, top: 4, right: 8),
                                                    child: Text(
                                                      item.title,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                        FontFamily.poppins,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.textColor,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                    child: Text(
                                                      item.subtitle,
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        height: 1.1,
                                                        fontSize: 12,
                                                        fontFamily:
                                                        FontFamily.poppins,
                                                        fontWeight: FontWeight.w300,
                                                        color: AppColor.subtitleColor,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Gap(4),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: IntrinsicWidth(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: AppColor.bluePrimary, width: 1), // Outlined border
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Padding for inner content
                                                        child: Text(
                                                          item.targetClasses[index],
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: 'Poppins',
                                                            color: Colors.blue, // Text color
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Gap(4),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8),
                                                    child: Text(
                                                      'Date: ${controller.formatDate(item.dateTime)}',
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        height: 1.1,
                                                        fontSize: 12,
                                                        fontFamily:
                                                        FontFamily.poppins,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.titleColor,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                        "Notice Board",
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
