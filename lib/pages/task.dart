import 'package:flutter/material.dart';
import 'package:hushangbang/global/Global.dart';
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('任务大厅'),
        onPressed: () async {
          var res  = await Global.getInstance().dio.get('/login');
          print(res);
        },
      ),
    );
  }
}
