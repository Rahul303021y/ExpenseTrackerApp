import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:expensetrackerapp/shared/utils/dotter_border_box.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuildAttachmentButton extends StatelessWidget {
  final String title;
  final List<PlatformFile> selectedFiles;
  final ValueChanged<List<PlatformFile>> onFilesSelected;

  const BuildAttachmentButton({
    super.key,
    required this.title,
    required this.selectedFiles,
    required this.onFilesSelected,
  });

  Future<void> _pickFiles() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null) {
      onFilesSelected([...selectedFiles, ...result.files]);
    }
  }

  void _removeFile(PlatformFile file) {
    final updated = [...selectedFiles]..remove(file);
    onFilesSelected(updated);
  }

  @override
  Widget build(BuildContext context) {
    final hasFiles = selectedFiles.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _pickFiles,
          borderRadius: BorderRadius.circular(14),
          child: DottedBorderBox(
            selected: hasFiles,
            selectionColor: Theme.of(context).appColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle,
                  color: hasFiles ? Theme.of(context).appColors.primary : Theme.of(context).appColors.textSecondary.withOpacity(0.5),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: hasFiles ? Theme.of(context).appColors.primary : Theme.of(context).appColors.textSecondary.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (selectedFiles.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: selectedFiles
                .map(
                  (file) => Chip(
                label: Text(
                  file.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).appColors.textPrimary),
                ),
                backgroundColor: Theme.of(context).appColors.surfaceContainer,
                side: BorderSide(color: Theme.of(context).appColors.outline),
                deleteIcon: Icon(
                  Icons.close,
                  size: 16,
                  color: Theme.of(context).appColors.onSurfaceVariant,
                ),
                onDeleted: () => _removeFile(file),
              ),
            )
                .toList(),
          ),
        ],
      ],
    );
  }
}