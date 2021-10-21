import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:yizz_plugin/tool/global/global_method.dart';
import 'package:yizz_plugin/tool/utils/picker_util.dart';
import 'package:yizz_plugin/yizz_plugin.dart';
//import 'package:yizz_plugin/yizz_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await YizzPlugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(onPressed:(){
                //await YizzPlugin.testSize();
                PickerUtil.selectImage();
              }, child: Text('单选')),
              ElevatedButton(onPressed:(){
                //await YizzPlugin.testSize();
                PickerUtil.selectMultiImage();
              }, child: Text('多选')),
              ElevatedButton(onPressed:(){
                //await YizzPlugin.testSize();
                PickerUtil.takePhotoImage();
              }, child: Text('相机')),
              ElevatedButton(onPressed:(){
                //await YizzPlugin.testSize();
                PickerUtil.selectVido();
              }, child: Text('选择视频')),
              TestButton(),
              ElevatedButton(onPressed:(){
                showToast('dsdsdsdsdsdsd');
              }, child: Text('测试')),
            ],
          ),
        ),
      ),
    );
  }
}

class TestButton extends StatefulWidget {
  const TestButton({Key? key}) : super(key: key);

  @override
  _TestButtonState createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {

  late AssetEntity entity;
  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed:() async {
          // var ent = await PickerUtil.selectAssets(context,type: RequestType.common);
          // setState(() {
          //   i=2;
          //   entity = ent![0];
          // });
          showDialogss();
        }, child: Text('Wechat')),
        if(i == 2) Image(image: AssetEntityImageProvider(entity),fit: BoxFit.cover,height: 100,width: 100,)
      ],
    );
  }
}


