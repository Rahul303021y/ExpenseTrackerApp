import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/utils/bottom_curve_clipper.dart';
import 'package:flutter/material.dart';

import '../../home_screen/common/header.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      child: SizedBox(
        height: HomeHeader.height,
        width: double.infinity,
        child: AppBackground(
          child: Center(child: Text("Add Expense Screen")),
        ),
      ),
    );
  }
}
