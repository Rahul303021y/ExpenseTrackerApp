import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final String headingName;
  const CommonHeader({super.key, required this.headingName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: Text(
                headingName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
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
