import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic.dart';
import 'state.dart';

class PersonPage extends StatelessWidget {
  final PersonLogic logic = Get.put(PersonLogic());
  final PersonState state = Get.find<PersonLogic>().state;

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ElevatedButton(
    //     child: Text('退出登录'),
    //     onPressed: () async {
    //       SharedPreferences prefs = await SharedPreferences.getInstance();
    //       prefs.remove('token'); //删除指定键
    //       prefs.clear();//清空键值对
    //       Get.offAllNamed('/login');
    //     },
    //   ),
    // );

    return Scaffold(
      backgroundColor: Color(0xfff4f5f5),
      appBar: AppBar(
        title: Text('我的'),
        elevation: 1.5,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 180,
            flexibleSpace: new FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x00000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Expanded(
                        flex: 3,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                bottom: 15.0,
                              ),
                              child: new Text(
                                '阿萨德',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.0),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                left: 30.0,
                              ),
                              child: new Text(
                                '京A 88888',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: new Padding(
                          padding: const EdgeInsets.only(
                            top: 40.0,
                            right: 30.0,
                          ),
                          child: new CircleAvatar(
                            radius: 35.0,
                            backgroundImage: new NetworkImage(
                                'https://avatars2.githubusercontent.com/u/20411648?s=460&v=4'),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      new MenuItem(
                        icon: Icons.face,
                        title: '体验新版本',
                        onPressed: () {
                          print("体验新版本  ----   >");
                        },
                      ),
                      new MenuItem(
                        icon: Icons.print,
                        title: '个人信息',
                      ),
                      new MenuItem(
                        icon: Icons.security,
                        title: '隐私设置',
                      ),
                      new MenuItem(
                        icon: Icons.title,
                        title: '修改密码',
                        onPressed: () {
                          Get.toNamed('find_pwd');
                        },
                      ),
                      new MenuItem(
                        icon: Icons.archive,
                        title: '退出登录',
                        onPressed: () async{
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('token'); //删除指定键
                          prefs.clear(); //清空键值对
                          Get.offAllNamed('/login');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onPressed;

  MenuItem({Key? key, this.icon, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 12.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: new Icon(
                      icon,
                      color: Colors.black54,
                    ),
                  ),
                  new Expanded(
                      child: new Text(
                    title.toString(),
                    style: new TextStyle(color: Colors.black54, fontSize: 16.0),
                  )),
                  new Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  )
                ],
              )),
          new Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Divider(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  ContactItem({Key? key, this.count, this.title, this.onPressed})
      : super(key: key);

  final String? count;
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: new Text('2', style: new TextStyle(fontSize: 18.0)),
          ),
          new Text('asd',
              style: new TextStyle(color: Colors.black54, fontSize: 14.0)),
        ],
      ),
    );
  }
}
