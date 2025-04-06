import 'package:cached_network_image/cached_network_image.dart';
import 'package:movieshub/modules/details/detail_controller.dart';

import '../../config/config.dart';
import '../../utils/widgets/star_rating.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    String bgAssetPath = Assets.images.blueBg.path;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            Get.back();
            return;
          }
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgAssetPath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Obx(() {
                          return Image(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            image: controller.movieImage.value.isEmpty
                                ? NetworkImage(
                                    "https://dev-images.chatie.ai/dev-cpa/folk/c9d00da2-7bd1-4bc0-94da-c30e6c1c4406.png")
                                : NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${controller.movieImage.value}'),
                            fit: BoxFit.fill,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 48.0, // Adjust as needed for top margin
                  left: 16.0, // Adjust as needed for left margin
                  child: Container(
                    width: 32.0, // Diameter of the round container (2 * radius)
                    height: 32.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white,
                    ),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back, color: AppColor.titleColor, ),
                        iconSize: 20,
                        onPressed: () {
                          Get.back();
                          print('Back button pressed');
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.37,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 16),
                            child: Obx(() {
                              return Text(
                                controller.title.value,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: FontFamily.poppins,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.titleColor,
                                ),
                                textAlign: TextAlign.start,
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Obx(() {
                              return Text(
                                controller.subtitle.value,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: FontFamily.poppins,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.titleColor,
                                ),
                                textAlign: TextAlign.start,
                              );
                            }),
                          ),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: StarRating(
                                      rating: controller.rating.value,
                                      starSize: 24.0),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'IMDB: ${controller.imdb}',
                                      style: const TextStyle(
                                        color: AppColor.subtitleColor,
                                        fontFamily: FontFamily.poppins,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Gap(12),
                                    InkWell(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.ios_share,
                                            color: AppColor.bluePrimary,
                                            size: 24),
                                      ),
                                      onTap: () {
                                        controller.shareCourse();
                                      },
                                    ),
                                    const Gap(8),
                                  ],
                                )
                              ],
                            );
                          }),
                          const Gap(8),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: AppColor.grayBorder,
                          ),
                          const Gap(8),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Production',
                              style: TextStyle(
                                color: AppColor.subtitleColor,
                                fontFamily: FontFamily.poppins,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://dev-images.chatie.ai/dev-cpa/folk/0e6fc915-225c-449e-bb01-c9bb62f0b704.png',
                                    fit: BoxFit.fill,
                                    height: 54.0,
                                    // Set the height of the circular image
                                    width: 54.0,
                                    // Set the width equal to the height for a perfect circle
                                    placeholder: (context, url) => Container(
                                      height: 54.0,
                                      width: 54.0,
                                      color: Colors.grey[200],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      size: 54.0,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.company.value,
                                          style: TextStyle(
                                            color: AppColor.subtitleColor,
                                            fontFamily: FontFamily.poppins,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          controller.based.value,
                                          style: TextStyle(
                                            color: AppColor.subtitleColor,
                                            fontFamily: FontFamily.poppins,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const Gap(16),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Overview',
                              style: TextStyle(
                                color: AppColor.subtitleColor,
                                fontFamily: FontFamily.poppins,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                controller.overview.value,
                                style: const TextStyle(
                                  color: AppColor.subtitleColor,
                                  fontFamily: FontFamily.poppins,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }),
                          const Gap(12),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              "What you'll learn",
                              style: TextStyle(
                                color: AppColor.subtitleColor,
                                fontFamily: FontFamily.poppins,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            height: 54,
                            margin: EdgeInsets.only(left: 16),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.movieGenres.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Chip(
                                    label: Text(
                                      controller.movieGenres[index],
                                      maxLines: 2,
                                      // Allow up to 2 lines of text
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColor.subtitleColor,
                                        fontFamily: FontFamily.poppins,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ), // Truncate text with ellipsis if it overflows
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColor.bluePrimary),
                                      borderRadius: BorderRadius.circular(
                                          16.0), // Adjust as needed
                                    ),
                                    backgroundColor: AppColor.white,
                                    // Make background transparent
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            8.0), // Add padding around the text
                                  ),
                                );
                              },
                            ),
                          ),
                          Gap(16),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            height: 54,
                            child: SizedBox(
                              width: double.infinity,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.bluePrimary
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
                              ),
                            ),
                          ),
                          Gap(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
