import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormExample(),
    );
  }
}
class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}
class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>(); // المفتاح العالمي للنموذج
  String _name = '';
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('نموذج Flutter')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ربط المفتاح بالنموذج
          child: Column(
            children: [
              // حقل الاسم
              TextFormField(
                decoration: InputDecoration(labelText: 'الاسم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الاسم مطلوب';
                  }
                  return null; // إذا كان صالحًا
                },
                onSaved: (value) => _name = value!,
              ),

              // حقل البريد الإلكتروني
              TextFormField(
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'بريد إلكتروني غير صالح';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),

              SizedBox(height: 20),

              // زر الإرسال
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) { // التحقق من الصحة
                    _formKey.currentState!.save(); // حفظ البيانات
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم الإرسال: $_name, $_email')),
                    );
                  }
                },
                child: Text('إرسال'),
              ),
              // زر إعادة التعيين
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.reset(); // إعادة تعيين الحقول
                },
                child: Text('إعادة تعيين'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*شرح الكود
1.	GlobalKey<FormState>:
o	تُربط بالنموذج (Form) للوصول إلى حالته (FormState).
2.	TextFormField:
o	validator: دالة للتحقق من صحة القيمة.
o	onSaved: تحفظ القيمة عند استدعاء save().
3.	التحقق والإرسال:
o	validate(): تتحقق من جميع الحقول.
o	save():  تحفظ القيم في المتغيرات.
4.	إعادة التعيين:
o	reset(): تُعيد الحقول إلى حالتها الأولية.
________________________________________
النتيجة المتوقعة
•	عند إدخال بيانات غير صالحة، تظهر رسائل خطأ.
•	عند النقر على "إرسال" مع بيانات صالحة، تُعرض البيانات في SnackBar.
•	زر "إعادة تعيين" يمسح كل الحقول.*/


