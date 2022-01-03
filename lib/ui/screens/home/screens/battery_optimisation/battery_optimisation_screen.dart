import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_controller.dart';

class BatteryOptimisationScreen extends GetWidget<NodeStatusController> {
  static const String routeName = "/home/battery_optimisation";

  const BatteryOptimisationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("BATTERY OPTIMISATION")),
    );
  }
}