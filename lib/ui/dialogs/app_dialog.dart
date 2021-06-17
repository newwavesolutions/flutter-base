import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_text_styles.dart';

enum DialogType { INFO, SUCCESS, ERROR }

class AppDialog {
  final BuildContext context;
  final DialogType type;
  final String title;
  final String description;
  final String okText;
  final VoidCallback onOkPressed;
  final String cancelText;
  final VoidCallback onCancelPressed;
  final bool dismissible;
  final VoidCallback onDismissed;

  AppDialog({
    @required this.context,
    this.type = DialogType.INFO,
    this.title,
    this.description,
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.onDismissed,
    this.dismissible = false,
  }) : assert(
          context != null,
        );

  void show() {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return _buildDialog;
        });
  }

  Widget get _buildDialog {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () {
            if (dismissible == true) {
              dismiss();
            }
          },
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Column(
                              children: [
                                _buildTitleText,
                                _buildDescriptionText,
                                _buildActions,
                              ],
                            ),
                          ),
                        ],
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
  }

  Widget get _buildTitleText {
    if ((title ?? '').isEmpty) return Container();
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: AppTextStyle.blackS16Bold,
      ),
    );
  }

  Widget get _buildDescriptionText {
    if ((description ?? '').isEmpty) return Container();
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        description ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget get _buildActions {
    bool showOkButton = (okText ?? '').isNotEmpty;
    bool showCancelButton = (cancelText ?? '').isNotEmpty;
    List<Widget> buttons = [];
    if (showOkButton) {
      buttons.add(_buildOkButton);
    }
    if (showCancelButton) {
      buttons.add(_buildCancelButton);
    }
    return Container(
      // color: Colors.red,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }

  Widget get _buildOkButton {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        dismiss();
        onOkPressed?.call();
      },
      child: Text(
        okText,
        style: AppTextStyle.tintS14,
      ),
    );
  }

  Widget get _buildCancelButton => FlatButton(
        onPressed: () {
          dismiss();
          onCancelPressed?.call();
        },
        child: Text(
          cancelText ?? 'Cancel',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF005CF7),
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Colors.transparent,
      );

  dismiss() {
    Navigator.of(context).pop();
    onDismissed?.call();
  }

  Future<bool> _onWillPop() async {
    return (dismissible == null);
  }
}
