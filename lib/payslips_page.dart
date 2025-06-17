import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';


class PayslipsPage extends StatelessWidget {
  const PayslipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: const Text("Save PDF to Downloads"),
      onPressed: () => downloadPdf(context, "payslip.pdf", "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"),
    );
  }

  Future<void> downloadPdf(BuildContext context, fileName, pdfUrl) async {
    try {
      // Step 1: Request storage permission (only for Android)
      //This step assumes we are using Android version 11 or higher atleast ***
      if (Platform.isAndroid) {
        final status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission denied.")),
          );
          return;
        }
      }

      // Step 2: Get Downloads folder path
      String downloadPath;
      if (Platform.isAndroid) {
        downloadPath = "/storage/emulated/0/Download"; // Android Downloads folder
      } else if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        downloadPath = dir.path; // App sandbox
      } else {
        throw UnsupportedError("Unsupported platform");
      }

      final savePath = "$downloadPath/$fileName";

      // Step 3: Download file with Dio
      final dio = Dio();
      final response = await dio.download(
        pdfUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            debugPrint('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to Downloads: $fileName')),
        );

        final result = await OpenFile.open(savePath);
        debugPrint("OpenFile result: ${result.message}");

      } else {
        throw Exception('Download failed.');
      }
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download failed.")),
      );
    }
  }

}
