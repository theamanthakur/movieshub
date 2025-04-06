import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/config.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  String? scannedBarcode;
  String? fetchedData;
  bool isScanning = true;

  // Future<void> fetchData(String barcode) async {
  //   setState(() {
  //     fetchedData = 'Fetching data for: $barcode...';
  //   });
  //
  //   // Replace with your actual API endpoint that accepts the barcode
  //   final String apiUrl = 'YOUR_API_ENDPOINT/$barcode';
  //
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         fetchedData = 'API Response:\n${response.body}';
  //       });
  //     } else {
  //       setState(() {
  //         fetchedData =
  //         'Error fetching data. Status code: ${response.statusCode}';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       fetchedData = 'Error: $e';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty && isScanning) {
                      setState(() {
                        scannedBarcode = barcodes.first.rawValue;
                        isScanning =
                            false; // Stop scanning after first successful scan
                      });
                      cameraController.stop(); // Stop the camera
                      if (scannedBarcode != null) {
                        Get.snackbar(
                          'Result : $scannedBarcode',
                          'QR code value',
                          titleText: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Result : $scannedBarcode',
                              style: TextStyle(
                                  color: AppColor.greenPrimary,
                                  fontFamily: FontFamily.poppins,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          messageText: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              // 'explore'.tr,
                              'QR code value',
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
                        debugPrint('qr code value. :: $scannedBarcode');
                        Future.delayed(const Duration(seconds: 3)).then((_) {
                          // Or just () {
                          if (Get.isSnackbarOpen) {
                            Get.back();
                            Get.back();
                          } else {
                            Get.back();
                          }
                        });
                      }
                    }
                  },
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Scanned Barcode: ${scannedBarcode ?? "Not yet scanned"}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Fetch Result:\n${fetchedData ?? "Waiting for scan..."}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                scannedBarcode = null;
                fetchedData = null;
                isScanning = true;
              });
              cameraController.start(); // Restart the camera for a new scan
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              height: 54,
              child: SizedBox(
                width: 300,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.bluePrimary,
                  ),
                  child: const Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: Center(
                        child: Text(
                          "Scan Again",
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
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       setState(() {
          //         scannedBarcode = null;
          //         fetchedData = null;
          //         isScanning = true;
          //       });
          //       cameraController.start(); // Restart the camera for a new scan
          //     },
          //     child: const Text('Scan Again'),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: BarcodeScannerScreen(),
  ));
}
