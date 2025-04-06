import 'package:blurrycontainer/blurrycontainer.dart';

import '../../config/config.dart';
import '../../utils/widgets/banner_home.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final scrollController = ScrollController();

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: EdgeInsets.only(
                      top: 32,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColor.blue, AppColor.blueDark],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Image(
                              image: AssetImage(
                                Assets.images.iSearch.path,
                              ),
                              height: 24,
                              width: 24,
                              color: AppColor.subtitleColor,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(AppRoute.search);
                          },
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoute.scanner);
                          },
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Image(
                              image: AssetImage(
                                Assets.images.scan.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                  BannerCarousel(
                    bannerList: controller.bannerImages,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Now Playing",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Obx(() {
                    if (controller.listMoviesNow.isEmpty)
                      return SizedBox.shrink();
                    return Container(
                      height: 175,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listMoviesNow.length,
                        itemBuilder: (context, index) {
                          final item = controller.listMoviesNow[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.details,
                                  arguments: {
                                    "id": item.id,
                                  },
                                );
                              },
                              child: Container(
                                width: 141,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: AppColor.white.withOpacity(0.5),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: Image(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500/${item.poster_path}'),
                                          fit: BoxFit.cover,
                                          height: 175,
                                          width: 141,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 110,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12.0),
                                            bottomRight: Radius.circular(12.0),
                                          ),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColor.transparentBlack,
                                              Colors.black,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
                                              child: Text(
                                                item.title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: FontFamily.poppins,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 8),
                                              child: Text(
                                                item.overview,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  height: 1.1,
                                                  fontSize: 12,
                                                  fontFamily: FontFamily.poppins,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.white,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Gap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Popular",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Obx(() {
                    if (controller.listMoviesPop.isEmpty)
                      return SizedBox.shrink();
                    return Container(
                      height: 120,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listMoviesPop.length,
                        itemBuilder: (context, index) {
                          final item = controller.listMoviesPop[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.details,
                                  arguments: {
                                    "id": item.id,
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 116,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.white.withOpacity(0.5),
                                ),
                                child: BlurryContainer(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 116,
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
                                              'https://image.tmdb.org/t/p/w500/${item.poster_path}'),
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
                                                item.overview,
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
                                            Row(
                                              children: [
                                                Gap(8),
                                                Text(
                                                  'IMDB: ${item.vote_average} (${item.vote_count})',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    height: 1.1,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.poppins,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.titleColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Spacer(),
                                                item.adult
                                                    ? Image(
                                                        image: AssetImage(Assets
                                                            .images.all.path),
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image(
                                                        image: AssetImage(Assets
                                                            .images.au.path),
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.fill,
                                                      ),
                                                Gap(8),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                'Released: ${item.release_date}',
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
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Gap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Top Rated",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Obx(() {
                    if (controller.listMoviesTop.isEmpty)
                      return SizedBox.shrink();
                    return Container(
                      height: 165,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listMoviesTop.length,
                        itemBuilder: (context, index) {
                          final item = controller.listMoviesTop[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.details,
                                  arguments: {
                                    "id": item.id,
                                  },
                                );
                              },
                              child: Container(
                                width: 141,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.white.withOpacity(0.5),
                                ),
                                child: BlurryContainer(
                                  width: 141,
                                  height: 170,
                                  elevation: 2,
                                  color: AppColor.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  blur: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Gap(8),
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          // Apply borderRadius to all corners
                                          child: Image(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500/${item.poster_path}'),
                                            fit: BoxFit.cover,
                                            // Use BoxFit.cover to fill the bounds
                                            height: 100,
                                            width: 88,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 8, top: 8, right: 8),
                                        child: Text(
                                          item.title,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.textColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          item.overview,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 1.1,
                                            fontSize: 12,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w300,
                                            color: AppColor.subtitleColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Gap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Obx(() {
                    if (controller.listMoviesUp.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      height: 200,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listMoviesUp.length,
                        itemBuilder: (context, index) {
                          final item = controller.listMoviesUp[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.details,
                                  arguments: {
                                    "id": item.id,
                                  },
                                );
                              },
                              child: Container(
                                width: 141,
                                height: 190,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.white.withOpacity(0.5),
                                ),
                                child: BlurryContainer(
                                  width: 141,
                                  height: 190,
                                  elevation: 2,
                                  color: AppColor.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  blur: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          // Apply borderRadius to all corners
                                          child: Image(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500/${item.poster_path}'),
                                            fit: BoxFit.cover,
                                            // Use BoxFit.cover to fill the bounds
                                            height: 130,
                                            width: 141,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 8, top: 8, right: 8),
                                        child: Text(
                                          item.title,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.textColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          item.overview,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 1.1,
                                            fontSize: 12,
                                            fontFamily: FontFamily.poppins,
                                            fontWeight: FontWeight.w300,
                                            color: AppColor.subtitleColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Gap(16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Daily Notes',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Container(
                    height: 54,
                    margin: EdgeInsets.only(top: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.listMovieType.length,
                              itemBuilder: (context, index) {
                                final item = controller.listMovieType[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.selectedMovie.value ==
                                        item) {
                                      controller.selectedMovie.value = "";
                                    } else {
                                      controller.selectedMovie.value = item;
                                    }
                                  },
                                  child: Obx(() {
                                    var isSelected =
                                        controller.listMovieType[index] ==
                                            controller.selectedMovie.value;
                                    return Container(
                                      height: 54,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
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
                                            BorderRadius.circular(28.0),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColor.transparent
                                              : AppColor.transparent,
                                        ),
                                      ),
                                      child: BlurryContainer(
                                        color: !isSelected
                                            ? AppColor.white.withOpacity(0.6)
                                            : AppColor.transparent,
                                        elevation: 4,
                                        blur: isSelected ? 0 : 5,
                                        borderRadius:
                                            BorderRadius.circular(28.0),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                        ),
                                        child: Center(
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
                  Gap(8),
                  Obx(() {
                    if (controller.listDailyNotes.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 16, bottom: 60),
                        color: AppColor.transparent,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.listDailyNotes.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 48),
                            itemBuilder: (context, index) {
                              final item = controller.listDailyNotes[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
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
                                                    Assets.images.bulb.path),
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
                                              child: const Text(
                                                'Teacher Title',
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
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Image.asset(
                                              Assets.images.saveBlank.path,
                                              fit: BoxFit.fitHeight,
                                              height: 20,
                                              width: 20,
                                              color: AppColor.bluePrimary,
                                            ),
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
          ),
        ));
  }
}
