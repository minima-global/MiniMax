import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_controller.dart';

class NewsFeedScreen extends GetWidget<NodeStatusController> {
  static const String routeName = "/home/news_feed";

  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("NEWS FEED")),
    );
  }
}
