import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArScreen extends StatelessWidget {
  final arModel;
  ArScreen({Key? key, this.arModel});

  @override
  Widget build(BuildContext context) {
    if (arModel == null || arModel == '') {
      return Scaffold(
        appBar: AppBar(
          title: Text("AR Screen"),
          backgroundColor: Color(0xFF4C53A5),
        ),
        body: Center(
          child: const Text("AR model for this product is not available yet."),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("AR Screen"),
          backgroundColor: Color(0xFF4C53A5),
        ),
        body: ModelViewer(
          src: arModel,
          ar: true,
          arPlacement: ArPlacement.floor,
          cameraControls: true,
        ),
      );
    }
  }
}
