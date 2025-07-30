import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageViewerScreen(),
    );
  }
}

class ImageViewerScreen extends StatefulWidget {
  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset _initialOffset = Offset.zero;
  double _initialScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('عرض الصورة')),
      body: Center(
        child: GestureDetector(
          onScaleStart: (details) {
            _initialOffset = _offset;
            _initialScale = _scale;
          },
          onScaleUpdate: (details) {
            setState(() {
              _scale = _initialScale * details.scale;
              _offset = _initialOffset + details.focalPoint - details.localFocalPoint;
            });
          },
          onDoubleTap: () {
            setState(() {
              _scale = _scale == 1.0 ? 2.0 : 1.0; // تبديل التكبير
            });
          },
          onLongPress: () {
            setState(() {
              _scale = 1.0;
              _offset = Offset.zero;
            });
          },
          child: Transform(
            transform: Matrix4.identity()
              ..scale(_scale)
              ..translate(_offset.dx, _offset.dy),
            child: Image.asset('images/elephant.jpeg'),
          ),
        ),
      ),
    );
  }
}

//لا تنسي بانشاء مجلد images واضافة الصورة اليه
//لا تنسي باضافة ذلك الى ملف pubspec.yaml
