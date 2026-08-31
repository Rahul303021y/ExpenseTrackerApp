/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:52
 * Product Name: Expenzo
 * ________________________________
 */

import 'dart:typed_data';

import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_attachment_model.dart';
import 'package:flutter/material.dart';

class AttachmentGrid extends StatelessWidget {
  final List<ExpenseAttachment> attachments;
  final Future<Uint8List> Function(String uuid) fetchBytes;
  final void Function(ExpenseAttachment attachment) onImageTap;
  final void Function(ExpenseAttachment attachment) onPdfTap;

  const AttachmentGrid({
    super.key,
    required this.attachments,
    required this.fetchBytes,
    required this.onImageTap,
    required this.onPdfTap,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    if (attachments.length == 1) {
      return AspectRatio(
        aspectRatio: 1,
        child: _AttachmentTile(
          attachment: attachments.first,
          fetchBytes: fetchBytes,
          onTap: () => _handleTap(attachments.first),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attachments.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final attachment = attachments[index];
        return _AttachmentTile(
          attachment: attachment,
          fetchBytes: fetchBytes,
          onTap: () => _handleTap(attachment),
        );
      },
    );
  }

  void _handleTap(ExpenseAttachment attachment) {
    if (attachment.isPdf) {
      onPdfTap(attachment);
    } else {
      onImageTap(attachment);
    }
  }
}

class _AttachmentTile extends StatelessWidget {
  final ExpenseAttachment attachment;
  final Future<Uint8List> Function(String uuid) fetchBytes;
  final VoidCallback onTap;

  const _AttachmentTile({
    required this.attachment,
    required this.fetchBytes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          child: attachment.isPdf ? _buildPdfTile() : _buildImageTile(),
        ),
      ),
    );
  }

  Widget _buildPdfTile() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 32),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              attachment.fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile() {
    return FutureBuilder<Uint8List>(
      future: fetchBytes(attachment.uuid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey),
          );
        }

        return Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }
}