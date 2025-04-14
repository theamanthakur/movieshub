import 'dart:async';
import 'dart:io';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:movieshub/config/config.dart';
import 'package:path_provider/path_provider.dart';

class EBookController extends BaseController{

  int totalPages = 0;
  final currentPage = 0.obs;
  late PDFViewController pdfViewController;
  bool isReady = false;
  final path = "".obs;


  @override
  Future<void> onInit() async {
    // String path = await getPdfFileFromAssets("assets/pdf/sample.pdf");
    var pdfPath = await fromAsset("assets/pdf/ebook_sample.pdf", 'sample.pdf');
    path.value = pdfPath;
    debugPrint('path of pdf ::  $path');
    super.onInit();
  }


  Future<String> fromAsset(String asset, String filename) async {
    try {
      // Get the appropriate directory for storing files
      final dir = Platform.isAndroid
          ? await getDownloadsDirectory()  // For Android, use the Downloads directory
          : await getApplicationDocumentsDirectory();  // For iOS, use the Documents directory

      // Create the file in the chosen directory
      File file = File("${dir?.path}/$filename");

      // Load the asset as bytes
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();

      // Write the bytes to the file
      await file.writeAsBytes(bytes, flush: true);

      // Return the path of the file as a string
      return file.path;
    } catch (e) {
      throw Exception('Error copying asset file: $e');
    }
  }
  //
  // Future<File> fromAsset(String asset, String filename) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();
  //
  //   try {
  //     final dir = Platform.isAndroid
  //         ? await getDownloadsDirectory()
  //         : await getApplicationDocumentsDirectory();
  //
  //     File file = File("${dir?.path}/$filename");
  //     var data = await rootBundle.load(asset);
  //     var bytes = data.buffer.asUint8List();
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }
  //
  //   return completer.future;
  // }

}