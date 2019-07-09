import 'dart:async' as DeviceServiceTypesList;
import 'package:flutter/material.dart';
import 'package:nat_explorer/pages/device/commonDevice/services/tcpPortListPage.dart';
import 'package:nat_explorer/pages/device/commonDevice/services/udpPortListPage.dart';
import 'package:nat_explorer/pages/device/commonDevice/services/ftpPortListPage.dart';
import 'package:nat_explorer/pb/service.pb.dart';

class CommonDeviceServiceTypesList extends StatelessWidget {
  Device device;
  static const String TAG_START = "startDivider";
  static const String TAG_END = "endDivider";
  static const String TAG_CENTER = "centerDivider";
  static const String TAG_BLANK = "blankDivider";

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final imagePaths = [
    "images/ic_discover_softwares.png",
    "images/ic_discover_git.png",
    "images/ic_discover_gist.png",
    "images/ic_discover_scan.png",
    "images/ic_discover_shake.png",
    "images/ic_discover_nearby.png",
    "images/ic_discover_pos.png",
  ];
  final titles = ["TCP端口", "UDP端口", "FTP端口"];
  final rightArrowIcon = Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  final titleTextStyle = TextStyle(fontSize: 16.0);
  final List listData = [];

  CommonDeviceServiceTypesList(this.device) {
    initData();
  }

  initData() {
    listData.add(TAG_START);
    listData.add(ListItem(title: titles[0], icon: imagePaths[0]));
//    listData.add(TAG_CENTER);
    listData.add(TAG_END);
    listData.add(TAG_BLANK);
    listData.add(TAG_START);
    listData.add(ListItem(title: titles[1], icon: imagePaths[1]));
    listData.add(TAG_END);
    listData.add(TAG_BLANK);
    listData.add(TAG_START);
    listData.add(ListItem(title: titles[2], icon: imagePaths[2]));
    listData.add(TAG_END);
  }

  Widget getIconImage(path) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child:
          Image.asset(path, width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH),
    );
  }

  renderRow(BuildContext ctx, int i) {
    var item = listData[i];
    if (item is String) {
      switch (item) {
        case TAG_START:
          return Divider(
            height: 1.0,
          );
          break;
        case TAG_END:
          return Divider(
            height: 1.0,
          );
          break;
        case TAG_CENTER:
          return Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: Divider(
              height: 1.0,
            ),
          );
          break;
        case TAG_BLANK:
          return Container(
            height: 20.0,
          );
          break;
      }
    } else if (item is ListItem) {
      var listItemContent = Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Row(
          children: <Widget>[
            getIconImage(item.icon),
            Expanded(
                child: Text(
              item.title,
              style: titleTextStyle,
            )),
            rightArrowIcon
          ],
        ),
      );
      return InkWell(
        onTap: () {
          handleListItemClick(ctx, item);
        },
        child: listItemContent,
      );
    }
  }

  void handleListItemClick(BuildContext ctx, ListItem item) {
    String title = item.title;
    if (title == "TCP端口") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
        return TcpPortListPage(device:device);
      }));
    } else if (title == "UDP端口") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
        return UdpPortListPage(device:device);
      }));
    } else if (title == "FTP端口") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) {
        return FtpPortListPage(device:device);
      }));
    }
  }

  DeviceServiceTypesList.Future scan() async {
    try {} on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("服务")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, i) => renderRow(context, i),
        ),
    ));
  }
}

class ListItem {
  String icon;
  String title;
  ListItem({this.icon, this.title});
}
