import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';

class DialogUtils {
  static Future<File> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<File> pickImageFromLibrary() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<File> pickDocument() async {
    //Without parameters:
    final path = await FlutterDocumentPicker.openDocument();
    if ((path ?? "").isNotEmpty) {
      return File(path);
    } else {
      return null;
    }

    // //With parameters:
    // FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
    // allowedFileExtensions: ['mwfbak'],
    // allowedUtiTypes: ['com.sidlatau.example.mwfbak'],
    // allowedMimeTypes: ['application/*'],
    // invalidFileNameSymbols: ['/'],
    // );
    //
    // final path = await FlutterDocumentPicker.openDocument(params: params);
  }

  static void showDatePicker(
    BuildContext context, {
    DateTime minTime,
    DateTime maxTime,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) {
    DatePicker.showDatePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType.vi,
      currentTime: currentTime,
      theme: DatePickerTheme(),
    );
  }

  static void showDateTimePicker(
    BuildContext context, {
    DateTime minTime,
    DateTime maxTime,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) {
    DatePicker.showDateTimePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType.vi,
      currentTime: currentTime,
      theme: DatePickerTheme(),
    );
  }
}
