import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hushangbang/components/PhotoViewSimpleScree.dart';


import 'logic.dart';
import 'state.dart';

class UpdateAvatarPage extends StatelessWidget {
  final PersonLogic logic = Get.put(PersonLogic());
  final PersonState state = Get.find<PersonLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f5f5),
      appBar: AppBar(
        title: Text('修改头像'),
        elevation: 1.5,
        centerTitle: true,
      ),
      body:Container(
        color: Color(0xfff4f5f5), //背景色
        padding: EdgeInsets.all(10 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Expanded(child: Text('请上传新头像：' ,style: TextStyle(fontWeight: FontWeight.w600),))],),
            SizedBox(height: 15),

            GetBuilder<PersonLogic>(
              builder: (logic) {
                List<Widget> list = [];
                for (var i = 0; i < state.imgUrl.length; i++) {
                  String remoteUrl  = state.imgUrl[i];
                  list.add(Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Color(0xfff4f5f5),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black26),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: GestureDetector(
                          child: Image.network(
                            remoteUrl,
                            fit: BoxFit.fill,
                          ),
                          onTap: (){
                            Get.to(PhotoViewSimpleScreen(
                                imageProvider: NetworkImage(remoteUrl,scale: 0.9), heroTag: 'simple')
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: -7,
                        top: -10,
                        child: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: (){
                            logic.deleteImage(remoteUrl);
                          },
                        ),
                      )
                    ],
                  ));
                }

                if (state.imgUrl.length < state.maxSize) {
                  list.add(GestureDetector(
                    onTap: logic.selectImageOrigin,
                    child: Container(
                      width: 180,
                      height: 180,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xfff4f5f5),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black26),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 1.0,
                                spreadRadius: 1.0),
                          ]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.photo_camera),
                      ),
                    ),
                  ));
                }
                return Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 10 * 2,
                  children: list,
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle:
                      TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: logic.submit,
                  child: Text('提 交'),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
