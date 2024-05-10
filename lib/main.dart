import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _perPage = 10;
  int _counter = 0;
  final List<int> _data = [];
  double? _height = 100;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      onAttach: (position) {
        handleAttach();
      },
    );
    _scrollController.addListener(_scrollListener);
    loadData();
  }

  void handleAttach() {
    // setState(() {
    _height = MediaQuery.of(context).size.height / 2;
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadData() {
    // Simulating loading data asynchronously
    Future.delayed(const Duration(seconds: 2), () {
      final newData =
          List.generate(_perPage, (index) => _counter * _perPage + index + 1);
      setState(() {
        _data.addAll(newData);
        _counter++;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      loadData();
      // _height = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll Example'),
      ),
      body: Column(
        children: [
          Expanded(
            // height: _height,
            child: ListView.builder(
              shrinkWrap: false,
              controller: _scrollController,
              itemCount: _data.length + 1,
              itemBuilder: (context, index) {
                if (index < _data.length) {
                  return Container(
                    // color: Colors.red,
                    child: ListTile(
                      title: Text('Item ${_data[index]}'),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 200,
                    // color: Colors.green,
                    // height: ,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
