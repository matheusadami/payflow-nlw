import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:payflow/modules/barcodeScanner/barcodeScannerStatus.dart';

class BarcodeScannerController {

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  CameraController? cameraController;

  void getAvailableBackCamera() async {
    try {
      List<CameraDescription> response = await availableCameras();
      CameraDescription camera = response.firstWhere((e) => e.lensDirection == CameraLensDirection.back);
      cameraController = CameraController(camera, ResolutionPreset.max, enableAudio: false);
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  Future<void> scannerBarcode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);

      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }
    } catch (e) {
      print("ERRO DA LEITURA $e");
    }
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.availableCamera();
    Future.delayed(const Duration(seconds: 20)).then((value) {
      if (!status.hasBarcode && status.isCameraAvailable) {
        status = BarcodeScannerStatus.error('Timeout de leitura de boleto');
      }
    });
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages) return;

    cameraController!.startImageStream((cameraImage) async {
      if (!status.stopScanner) {
        try {
          final WriteBuffer allBytes = WriteBuffer();

          for (Plane plane in cameraImage.planes) {
            allBytes.putUint8List(plane.bytes);
          }

          final bytes = allBytes.done().buffer.asUint8List();

          final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

          final InputImageRotation imageRotation = InputImageRotation.Rotation_0deg;

          final InputImageFormat inputImageFormat =
            InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.NV21;

          final planeData = cameraImage.planes.map(
            (Plane plane) {
              return InputImagePlaneMetadata(
                bytesPerRow: plane.bytesPerRow, height: plane.height, width: plane.width
              );
            },
          ).toList();

          final inputImageData = InputImageData(
            size: imageSize, imageRotation: imageRotation, inputImageFormat: inputImageFormat, planeData: planeData
          );

          final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

          scannerBarcode(inputImage);
          await Future.delayed(const Duration(seconds: 1));
        } catch (e) { }
      }
    });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();

    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
