import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/utils/bottom_curve_clipper.dart';
import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/locale_keys.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? greeting;

  const HomeHeader({
    super.key,
    required this.userName,
    this.greeting,
  });

  static const double height = 300;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: AppBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).appColors.surface,
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).appColors.onBackground,
                          )),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting ?? LocaleKeys.goodDay.tr(context),
                            style:
                                TextStyle(color: Theme.of(context).appColors.onPrimary.withOpacity(0.7), fontSize: 14),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              color: Theme.of(context).appColors.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 2
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appColors.onSurfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        onPressed: () {
                          CustomSnackbar.info(context, "Coming Soon!!");
                        },
                        icon: Icon(Icons.notifications_none_rounded,
                            color: Theme.of(context).appColors.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
