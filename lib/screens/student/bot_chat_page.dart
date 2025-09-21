import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BotChatPage extends StatefulWidget {
  const BotChatPage({super.key});

  @override
  State<BotChatPage> createState() => _BotChatPageState();
}

class _BotChatPageState extends State<BotChatPage> {
  late final WebViewController _controller;

  final String botUrl =
      "https://cdn.botpress.cloud/webchat/v3.3/shareable.html?configUrl=https://files.bpcontent.cloud/2025/09/20/17/20250920171924-HNZ2N49A.json";

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(botUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Bot")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
