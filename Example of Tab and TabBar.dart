import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام التبويبات المتكامل',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 3,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تطبيق التبويبات'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black38,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'الرئيسية',
            ),
            Tab(
              icon: Icon(Icons.business),
              text: 'الأعمال',
            ),
            Tab(
              icon: Icon(Icons.school),
              text: 'التعليم',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTab(),
          BusinessTab(),
          EducationTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // إجراء عند الضغط على الزر
          final currentTab = _tabController.index;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('التبويب الحالي: ${_getTabName(currentTab)}'),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getTabName(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'الأعمال';
      case 2:
        return 'التعليم';
      default:
        return 'غير معروف';
    }
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'مرحبًا بك في التبويب الرئيسي',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class BusinessTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.work),
          title: Text('مشروع 1'),
          subtitle: Text('تفاصيل المشروع الأول'),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text('مشروع 2'),
          subtitle: Text('تفاصيل المشروع الثاني'),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text('مشروع 3'),
          subtitle: Text('تفاصيل المشروع الثالث'),
        ),
      ],
    );
  }
}

class EducationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school, size: 40),
                Text('مادة ${index + 1}'),
              ],
            ),
          ),
        );
      }),
    );
  }
}
