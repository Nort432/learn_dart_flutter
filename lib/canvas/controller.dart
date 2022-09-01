import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Controller {
  static const Size myIconSizeOval = Size(150, 150); // 80, 96
  static double toDegrees(double radians) {
    return radians * 180 / pi;
  }
  static double toRadians(double degree) {
    return degree * pi / 180;
  }

  static Future<Uint8List> createCanvas({
    required String text,
    required double degree,
    required Size iconSize,
  }) async {
    /// Записывает изображение, содержащее последовательность графических операций.
    /// Чтобы начать запись, создайте Canvas для записи команд.
    /// Чтобы закончить запись, используйте метод PictureRecorder.endRecording.
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();

    /// Интерфейс для записи графических операций.
    final Canvas canvas = Canvas(pictureRecorder);

    /// Angle of number
    double angleTemp = toRadians(degree);
    final double angle = -angleTemp;

    TextPainter painter = TextPainter(
      textDirection: ui.TextDirection.ltr,
    );

    /// Text number of train
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: iconSize.width / 4.4,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );

    painter.layout();

    canvas.save();

    /// Convert [Image] to [Uint8List]
    int imageWidth = myIconSizeOval.width.toInt();
    int imageHeight = myIconSizeOval.height.toInt();
    Uint8List iconUint8List = await _imageAssetToUint8List(
      source: 'assets/gps-train-2.png',
      width: imageWidth,
      height: imageHeight,
    );

    /// Convert [Uint8List] to [Image]
    final ui.Image _iconMarker = await uint8ListToImage(iconUint8List);

    /// Offset cut markers
    canvas.drawImage(_iconMarker, const Offset(0, 0), Paint());

    final double r = sqrt(iconSize.width * iconSize.width +
        iconSize.height * iconSize.height) /
        2;
    final alpha = atan(iconSize.height / iconSize.width);
    final beta = alpha + angle;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = iconSize.width / 2 - shiftX;
    final translateY = iconSize.height / 1.7 - shiftY;

    canvas.translate(translateX, translateY);
    canvas.rotate(angle);

    Offset of = Offset(
      (iconSize.width - painter.width) * 0.5,
      (iconSize.height - painter.height) * 0.5,
    );

    painter.paint(canvas, of);

    canvas.restore();

    final img = await pictureRecorder
        .endRecording()
        .toImage(iconSize.width.toInt(), iconSize.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  /// Convert [Image] to [Uint8List]
  static Future<Uint8List> _imageAssetToUint8List({
    required String source,
    required int width,
    required int height,
  }) async {

    final ByteData data = await rootBundle.load(source);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();

    Uint8List uint8list =
    (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();

    return uint8list;
  }

  /// Convert [Uint8List] to [Image]
  static Future<ui.Image> uint8ListToImage(Uint8List img) async {
    // Uint8List to Image
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }
}