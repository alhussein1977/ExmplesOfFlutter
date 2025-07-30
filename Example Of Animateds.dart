import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('أمثلة التحريك')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('AnimatedContainer', style: TextStyle(fontSize: 20)),
              AnimatedContainerExample(),
              Divider(),
              Text('AnimatedCrossFade', style: TextStyle(fontSize: 20)),
              CrossFadeExample(),
              Divider(),
              Text('AnimatedOpacity', style: TextStyle(fontSize: 20)),
              OpacityExample(),
            ],
          ),
        ),
      ),
    );
  }
}

class OpacityExample extends StatefulWidget {
  @override
  _OpacityExampleState createState() => _OpacityExampleState();
}

class _OpacityExampleState extends State<OpacityExample> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: _opacity,
          child: Text(
            'هذا النص سيتلاشى!',
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _opacity = _opacity == 1.0 ? 0.0 : 1.0; // تبديل الحالة
            });
          },
          child: Text(_opacity == 1.0 ? 'إخفاء النص' : 'إظهار النص'),
        ),
      ],
    );
  }
}
class CrossFadeExample extends StatefulWidget {
  @override
  _CrossFadeExampleState createState() => _CrossFadeExampleState();
}

class _CrossFadeExampleState extends State<CrossFadeExample> {
  bool _showImage = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          duration: Duration(seconds: 1),
          firstChild: Text('اضغط لرؤية الصورة', style: TextStyle(fontSize: 24)),
          secondChild: Image.asset('images/flower.png', height: 150),
          crossFadeState: _showImage ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showImage = !_showImage;
            });
          },
          child: Text(_showImage ? 'إخفاء الصورة' : 'إظهار الصورة'),
        ),
      ],
    );
  }
}
class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // تبديل الحالة
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1), // مدة الحركة
        curve: Curves.easeInOut, // نمط الحركة
        width: _isExpanded ? 200 : 100,
        height: _isExpanded ? 200 : 100,
        color: _isExpanded ? Colors.blue : Colors.red,
        child: Center(child: Text(_isExpanded ? 'اضغط للتقلص' : 'اضغط للتوسيع')),
      ),
    );
  }
}
//ملاحظات
//لا تنسي بانشاء مجلد images وبدخله الصورة التي تريد
//لا تنسي تعديل ملف pubspec.yaml لتضمين الصورة

