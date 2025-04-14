import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:movieshub/modules/poc/ebook/ebook_controller.dart';

import '../../../config/config.dart';

class EbookScreen extends StatelessWidget {
  EbookScreen({super.key});
  final controller = Get.put(EBookController());

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
                      height: MediaQuery.of(context).size.height * 0.75,
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
                      child: Obx((){
                        if(controller.path.isNotEmpty && controller.currentPage.value >= 0){
                          return PDFView(
                            filePath: controller.path.value,
                            enableSwipe: false, // Disable swipe to view one page at a time
                            swipeHorizontal: false,
                            autoSpacing: false,
                            pageFling: false,
                            onRender: (_pages) {
                              controller.totalPages = _pages ?? 0;
                            },
                            onViewCreated: (PDFViewController vc) {
                              controller.pdfViewController = vc;
                            },
                            onPageChanged: (int? page, int? total) {
                              controller.currentPage.value = page!;
                            },
                            onError: (error) {
                              print(error.toString());
                            },
                            onPageError: (page, error) {
                              print('$page: ${error.toString()}');
                            },
                          );
                        }else{
                          return SizedBox.shrink();
                        }

                      }),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: Get.height * 0.30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.dotGray.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "E-Book: Integral Calculus, Class 12th",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.poppins,
                              letterSpacing: 0.2),
                        ),
                      ),
                      Gap(16),
                      InkWell(
                        onTap: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.bluePrimary
                              ),
                              child:  Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "AI Summary",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: FontFamily.poppins,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Gap(8),
                                        Icon(Icons.star, color: AppColor.energyColorStart, size: 16,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: (){
                                if (controller.currentPage.value > 0) {
                                  // Decrement the current page value before setting the page
                                  controller.currentPage.value -= 1;
                                  controller.pdfViewController.setPage(controller.currentPage.value);
                                  debugPrint('current page value (Prev) :: ${controller.currentPage.value}');
                                }
                                debugPrint('current page value   ::  ${controller.currentPage.value}');
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(color: AppColor.bluePrimary),
                                backgroundColor: AppColor.white,
                              ),
                              child: Text('Prev'),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: (){
                                if (controller.currentPage.value + 1 < controller.totalPages) {
                                  // Increment the current page value before setting the page
                                  controller.currentPage.value += 1;
                                  controller.pdfViewController.setPage(controller.currentPage.value);
                                  debugPrint('current page value (Next) :: ${controller.currentPage.value}');
                                }
                                debugPrint('current page value   ::  ${controller.currentPage.value}');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.bluePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Next'),
                            ),
                          ),
                        ],
                      ),
                      Gap(16),
                    ],
                  ),
                ),
              )
            ],
          )
        ));
  }
}
