import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:ui' as ui;

class DynmapPage extends StatelessWidget {
  const DynmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Scaffold(
        body: Center(child: Text('Dynmap disponível apenas no navegador')),
      );
    }

    const String viewId = 'dynmap-iframe';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      return html.IFrameElement()
        ..src = 'http://localhost:8123/?worldname=world&mapname=surface'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    });

    return const HtmlElementView(viewType: viewId);
  }
}
