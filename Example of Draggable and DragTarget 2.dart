import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorChangerApp(),
    );
  }
}

class ColorChangerApp extends StatefulWidget {
  @override
  _ColorChangerAppState createState() => _ColorChangerAppState();
}

class _ColorChangerAppState extends State<ColorChangerApp> {
  Color _currentColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تغيير الألوان بالسحب')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDraggable(), // العنصر القابل للسحب
            _buildDragTarget(), // المنطقة المستهدفة
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء Draggable
  Draggable<int> _buildDraggable() {
    return Draggable<int>(
      data: Colors.deepOrange.value,
      child: Column(
        children: [
          Icon(Icons.palette, color: Colors.deepOrange, size: 48),
          Text('اسحبني لتغيير اللون'),
        ],
      ),
      feedback: Icon(Icons.brush, color: Colors.deepOrange, size: 80),
      childWhenDragging: Icon(Icons.palette, color: Colors.grey, size: 48),
    );
  }

  // دالة لإنشاء DragTarget
  DragTarget<int> _buildDragTarget() {
    return DragTarget<int>(
      onAccept: (colorValue) {
        setState(() {
          _currentColor = Color(colorValue);
        });
      },
      builder: (context, acceptedData, rejectedData) {
        return Container(
          width: 200,
          height: 200,
color: acceptedData.isEmpty ? _currentColor : Color(acceptedData[0] ?? 0xFF000000),          child: Center(
            child: Text(
              acceptedData.isEmpty 
                  ? 'اسحب اللون هنا' 
                  : 'اللون الجديد: ${acceptedData[0]}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

