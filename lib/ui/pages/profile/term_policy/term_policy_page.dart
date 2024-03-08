import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermPolicyPage extends StatefulWidget {
  const TermPolicyPage({super.key});

  @override
  State<TermPolicyPage> createState() => _TermPolicyPageState();
}

class _TermPolicyPageState extends State<TermPolicyPage> {
  final controller = WebViewController()
    ..loadRequest(Uri.parse('https://newwave.vn/vi/privacy-policy/'));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Term & Policy',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return WebViewWidget(
      controller: controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
