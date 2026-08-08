import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:expensetrackerapp/shared/utils/dotter_border_box.dart';
import 'package:flutter/material.dart';

class BuildAttachmentButton extends StatelessWidget {
  final String title;
  const BuildAttachmentButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomSnackbar.info(context, "Feature is coming soon!");
      },
      borderRadius: BorderRadius.circular(12),
      child: DottedBorderBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, color: Colors.black54, size: 20),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
