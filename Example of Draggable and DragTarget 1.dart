import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DragDropScreen(),
    );
  }
}
class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}
class _DragDropScreenState extends State<DragDropScreen> {
  Color _draggableColor = Colors.blue;
  bool _isDropped = false;
  String _dropStatus = 'اسحب الأيقونة إلى المنطقة المستهدفة';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مثال السحب والإفلات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // العنصر القابل للسحب
            Draggable<Color>(
              data: _draggableColor,
              feedback: Container(
                width: 100,
                height: 100,
                color: _draggableColor.withOpacity(0.7),
                child: Icon(Icons.drag_handle, size: 50, color: Colors.white),
              ),
              childWhenDragging: Container(
                width: 100,
                height: 100,
                color: Colors.grey,
              ),
              child: Container(
                width: 100,
                height: 100,
                color: _draggableColor,
                child: Icon(Icons.drag_handle, size: 50, color: Colors.white),
              ),
            ),
            // المنطقة المستهدفة
            DragTarget<Color>(
              onAccept: (Color color) {
                setState(() {
                  _isDropped = true;
                  _dropStatus = 'تم الإفلات بنجاح!';
                });
              },
              onWillAccept: (Color? color) {
                return color != null;
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200,
                  height: 200,
                  color: _isDropped ? _draggableColor : Colors.grey[300],
                  child: Center(
                    child: Text(
                      _dropStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
            // زر إعادة التعيين
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isDropped = false;
                  _dropStatus = 'اسحب الأيقونة إلى المنطقة المستهدفة';
                });
              },
              child: Text('إعادة التعيين'),
            ),
          ],
        ),
      ),
    );
  }
}
//*شرح الكود
1. العنصر القابل للسحب (Draggable)
•	نستخدم ويدجت Draggable  لإنشاء عنصر يمكن سحبه
•	 data: نمرر لون الأيقونة كبيانات يمكن نقلها
•	feedback:  شكل العنصر أثناء السحب (مع شفافية)
•	childWhenDragging:  ما يظهر مكان العنصر الأصلي أثناء السحب
•	child:  شكل العنصر الأصلي قبل السحب
2. المنطقة المستهدفة (DragTarget)
•	نستخدم ويدجت DragTarget لإنشاء منطقة تقبل العناصر المسحوبة
•	onAccept:  دالة تنفذ عند قبول العنصر المسحوب
•	onWillAccept:  دالة تحدد ما إذا كان يمكن قبول العنصر
•	builder:  يبني واجهة المنطقة المستهدفة
3. التغييرات الحالة (State Management) 
•	نستخدم setState لتحديث الواجهة عند:
o	نجاح عملية الإفلات
o	إعادة تعيين الحالة بالضغط على الزر
كيفية عمل التطبيق
1.	سحب الأيقونة الزرقاء من الأعلى
2.	إفلاتها في المنطقة الرمادية في المنتصف
3.	عند الإفلات الناجح، يتغير لون المنطقة إلى اللون الأزرق
4.	يمكن إعادة التعيين بالضغط على الزر في الأسفل
إمكانيات التطوير
1.	يمكن إضافة أصوات عند السحب والإفلات
2.	يمكن جعل المنطقة المستهدفة تتغير شكلها عند استقبال العنصر
3.	يمكن إضافة رسوم متحركة عند الإفلات الناجح
4.	يمكن دعم سحب وإفلات عناصر متعددة *//


