/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:54
 * Product Name: Expenzo
 * ________________________________
 */

import 'dart:io'; 
import 'dart:typed_data';

import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatefulWidget {
  final Future<Uint8List> fetchBytes;
  final String fileName;

  const FullScreenImageViewer({
    super.key,
    required this.fetchBytes,
    required this.fileName,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late Future<Uint8List> _imageBytes;

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.fetchBytes;
  }

  Future<void> _downloadImage(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File(
        '${directory.path}/${widget.fileName}',
      );

      await file.writeAsBytes(bytes);

      await OpenFile.open(file.path);

      if (!mounted) return;

      CustomSnackbar.info(
          context, LocaleKeys.imageDownloadedSuccessfully.tr(context));
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar.error(context, LocaleKeys.failedToDownloadImage.tr(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.fileName, 
          style: const TextStyle(color: Colors.white, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),

        actions: [
          FutureBuilder<Uint8List>(
            future: _imageBytes, 
            builder: (context, snapshot) {
              
              if (!snapshot.hasData) {
                
                return const SizedBox.shrink(); 
              } 

              return IconButton(
                
                onPressed: () => _downloadImage(snapshot.data!), 
                icon: const Icon(
                  
                  Icons.download, 
                  color: Colors.white, 
                ), 
                tooltip: LocaleKeys.download.tr(context),
              ); 
            }, 
          ), 
        ], 
      ),
      body: FutureBuilder<Uint8List>(
        future: _imageBytes, // ⭐ CHANGED
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(
              LocaleKeys.failedToLoadImage.tr(context),
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return PhotoView(
            imageProvider: MemoryImage(snapshot.data!),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          );
        },
      ),
    );
  }
}
