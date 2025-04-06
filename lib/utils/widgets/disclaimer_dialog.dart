import '../../config/config.dart';

class DisclaimerDialog extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const DisclaimerDialog({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColor.white;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      backgroundColor: AppColor.dialogBg.withOpacity(0.95),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: AppColor.dialogBg.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: AppColor.bluePrimary, width: 1.5)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child:  Container(
                height: 80,
                width: 80,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(color: AppColor.bluePrimary, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image(
                    image: AssetImage(imageUrl),
                    height: 20,
                    width: 20,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Spacing between image and text
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20.0,
                  height: 1.2,
                  fontFamily: FontFamily.poppins,
                  fontWeight: FontWeight.w600,
                  color: AppColor.titleColor),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              maxLines: 10,
              style: const TextStyle(
                fontSize: 12,
                height: 1.2,
                fontFamily: FontFamily.poppins,
                fontWeight: FontWeight.w400,
                color: AppColor.subtitleColor,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(16),
            // Text(
            //   subtitle2,
            //   maxLines: 3,
            //   style: const TextStyle(
            //     fontSize: 14,
            //     height: 1.2,
            //     fontFamily: FontFamily.roboto,
            //     fontWeight: FontWeight.w600,
            //     color: AppColor.borderBlue,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // Gap(24),

            Container(
              padding: EdgeInsets.only(left: 8, right: 16, ),
              height: 54,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: InkWell(
                  onTap: () {
                    onButtonPressed();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                        border: Border.all(color: AppColor.bluePrimary)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                      child: Center(
                        child: Text(
                          buttonText,
                          style: const TextStyle(
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
            ),
            Gap(16),
          ],
        ),
      ),
    );
  }
}

