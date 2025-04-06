import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:movieshub/modules/search/search_controller.dart';

import '../../config/config.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final controller = Get.put(SearchControllerApp());
  final scrollController = ScrollController();

  final hasFocus = true.obs;


  @override
  Widget build(BuildContext context) {
    String bgAssetPath = Assets.images.blueBg.path;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        Get.back();
      },
      child: Scaffold(
        backgroundColor: AppColor.transparent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.transparent,
            image: DecorationImage(
              image: AssetImage(bgAssetPath),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Gap(8),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
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
                      Gap(8),
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(30)),
                                  color: AppColor.white,
                                  boxShadow: hasFocus.value
                                      ? [
                                    BoxShadow(
                                        blurRadius: 0,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 0),
                                        color: Theme
                                            .of(context)
                                            .textFieldBorder,
                                        blurStyle: BlurStyle.normal),
                                  ]
                                      : null,
                                ),
                                child: TextField(
                                  controller: controller.searchController,
                                  focusNode: controller.focusNode,
                                  onTap: () {
                                    hasFocus.value = true;
                                    if (controller.query.value.isEmpty) {
                                      controller.getSearchResult('');
                                    } else {
                                      controller.getSearchResult(controller.query.value);
                                    }
                                  },
                                  onTapOutside: (p) {
                                    hasFocus.value = false;
                                    FocusScope.of(context).unfocus();
                                  },
                                  onChanged: (query) {
                                    controller.query.value = query;
                                    controller.getSearchResult(query);
                                  },
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColor.white,
                                    hintText: 'Search Favorite Movie',
                                    counterText: "",
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.textPurple),
                                      borderRadius: BorderRadius.all(Radius.circular(28)), // Change the color to purple
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(28)),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(28)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AppColor.bluePrimary),
                                        borderRadius: BorderRadius.all(Radius.circular(28))),
                                    contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 32, top: 16, bottom: 16),
                                    hintStyle: TextStyle(
                                      color: AppColor.gray,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.poppins,
                                    ),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization: TextCapitalization.sentences,
                                  minLines: 1,
                                  maxLength: 25,
                                  maxLines: 1,
                                ),
                              );
                            }),
                            Visibility(
                              visible: true,
                              child: PositionedDirectional(
                                end: 16,
                                child: InkWell(
                                  onTap: () {
                                    hasFocus.value = true;
                                    controller.query.value = '';
                                    // controller.searchController.setText("");
                                    controller.getSearchResult('');
                                    debugPrint("search text  ::  ${controller.searchController.text}");
                                    // if (hasFocus.value) {
                                    //   controller.searchController.text = "";
                                    // } else {}
                                  },
                                  child: Obx(() {
                                    debugPrint('query and hasfocus  ::  ${controller.query.value} and ${hasFocus.value}');
                                    return Image(
                                      height: 24,
                                      width: 24,
                                      image: (hasFocus.value && controller.query.value.isNotEmpty)
                                          ? AssetImage(Assets.images.close.path)
                                          : AssetImage(Assets.images.iSearch.path),
                                      color: AppColor.gray1,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(16)
                    ],
                  ),
                ),
                Gap(16),
                Expanded(
                  child: Obx(() {
                    if (controller.listMoviesSearch.isEmpty) return SizedBox.shrink();
                    return Container(
                      height: 120,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.listMoviesSearch.length,
                        itemBuilder: (context, index) {
                          final item = controller.listMoviesSearch[index];
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
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 116,
                                margin: EdgeInsets.only(top: 12,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.white.withOpacity(0.5),
                                ),
                                child: BlurryContainer(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 116,
                                  elevation: 2,
                                  color: AppColor.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  blur: 1,
                                  child: Row(
                                    children: [
                                      Gap(4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0), // Apply borderRadius to all corners
                                        child: Image(
                                          image: item.poster_path == null ?
                                          NetworkImage(
                                              "https://dev-images.chatie.ai/dev-cpa/folk/c9d00da2-7bd1-4bc0-94da-c30e6c1c4406.png")
                                           : NetworkImage(
                                              'https://image.tmdb.org/t/p/w500/${item.poster_path}') ,
                                          fit: BoxFit.cover, // Use BoxFit.cover to fill the bounds
                                          height: 100,
                                          width: 88,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 8, top: 4, right: 8),
                                              child: Text(
                                                item.title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: FontFamily.poppins,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.textColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                              EdgeInsets.symmetric(horizontal: 8),
                                              child: Text(
                                                item.overview,
                                                maxLines: 3,
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
                                            Gap(4),
                                            Row(
                                              children: [
                                                Gap(8),
                                                Text(
                                                  'IMDB: ${item.vote_average} (${item.vote_count})',
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    height: 1.1,
                                                    fontSize: 12,
                                                    fontFamily: FontFamily.poppins,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.titleColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Spacer(),
                                                item.adult ?
                                                Image(image: AssetImage(Assets.images.au.path), height: 20, width: 20, fit: BoxFit.fill,)
                                                    :Image(image: AssetImage(Assets.images.all.path), height: 20, width: 20, fit: BoxFit.fill,),
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
                                                  fontFamily: FontFamily.poppins,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
