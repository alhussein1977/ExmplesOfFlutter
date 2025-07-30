import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قائمة المهام مع خاصية السحب للحذف',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> _tasks = [
    'شراء البقالة',
    'إنهاء التقرير',
    'الاتصال بالعميل',
    'حضور الاجتماع',
    'إرسال البريد الإلكتروني'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المهام'),
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Text(
                'لا توجد مهام حالية',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_tasks[index]), // مفتاح فريد لكل مهمة
                  direction: DismissDirection.horizontal, // اتجاه السحب
                  confirmDismiss: (direction) async {
                    // تأكيد الحذف
                    if (direction == DismissDirection.startToEnd) {
                      // السحب من اليسار لليمين
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("تأكيد الحذف"),
                          content: Text("هل أنت متأكد من حذف هذه المهمة؟"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("إلغاء"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("حذف", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    }
                    return true;
                  },
                  onDismissed: (direction) {
                    setState(() {
                      final deletedTask = _tasks.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("تم حذف المهمة: $deletedTask"),
                          action: SnackBarAction(
                            label: "تراجع",
                            onPressed: () {
                              setState(() {
                                _tasks.insert(index, deletedTask);
                              });
                            },
                          ),
                        ),
                      );
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.green,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.task),
                      ),
                      title: Text(_tasks[index]),
                      subtitle: Text("اضغط مطولاً لتعديل المهمة"),
                      trailing: Icon(Icons.drag_handle),
                      onLongPress: () {
                        _editTask(context, index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addNewTask(context);
        },
      ),
    );
  }

  void _addNewTask(BuildContext context) async {
    final newTask = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text("إضافة مهمة جديدة"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "أدخل المهمة الجديدة"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("إلغاء"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text("إضافة"),
            ),
          ],
        );
      },
    );

    if (newTask != null && newTask.isNotEmpty) {
      setState(() {
        _tasks.add(newTask);
      });
    }
  }

  void _editTask(BuildContext context, int index) async {
    final editedTask = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _tasks[index]);
        return AlertDialog(
          title: Text("تعديل المهمة"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "عدل المهمة"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("إلغاء"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text("حفظ"),
            ),
          ],
        );
      },
    );

    if (editedTask != null && editedTask.isNotEmpty) {
      setState(() {
        _tasks[index] = editedTask;
      });
    }
  }
}
