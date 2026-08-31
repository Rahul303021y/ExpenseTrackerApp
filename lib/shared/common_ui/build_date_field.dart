import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildDateField extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const BuildDateField({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  State<BuildDateField> createState() => _BuildDateFieldState();
}

class _BuildDateFieldState extends State<BuildDateField> {
  late FocusNode _focusNode;

  String _formatDate(DateTime date) {
    const weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _pickDate(BuildContext context) async {
    _focusNode.requestFocus();

    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime.utc(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      widget.onDateChanged(picked);
    }

    // DON'T remove focus here.
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Focus(
      focusNode: _focusNode,
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return InkWell(
            onTap: () => _pickDate(context),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFocused
                      ? colors.primary
                      : colors.outline,
                  width: isFocused ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(widget.selectedDate),
                    style: TextStyle(
                      color: colors.textPrimary,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}