import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final String headingName;
  const CommonHeader({super.key, required this.headingName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).appColors.onPrimary,
                size: 25,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: Text(
                headingName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).appColors.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.more_horiz_rounded,
                color: Theme.of(context).appColors.onPrimary,
                size: 25,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
