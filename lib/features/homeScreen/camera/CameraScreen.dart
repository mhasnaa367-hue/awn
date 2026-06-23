import 'dart:io';

import 'package:awn/core/API/document_setup.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isLoading = true;
  XFile? _capturedImage;

  // Our ready-to-use document repository (built by the helper).
  final DocumentRepository _documents = createDocumentRepository();

  bool _isUploading = false; // true while we send the photo to the server

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _controller!.initialize();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();

      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _retakePicture() {
    setState(() {
      _capturedImage = null;
    });
  }

  // Send the captured photo to the server, then react to the result.
  Future<void> _confirmPicture() async {
    if (_capturedImage == null) return;

    setState(() => _isUploading = true);
    try {
      // 1) Call the upload API with the photo we just took.
      final result =
          await _documents.uploadDocument(filePath: _capturedImage!.path);

      // 2) Success -> print the message in the terminal...
      print('✅ Upload success: ${result.message}');
      print('   document id: ${result.id}, status: ${result.status}');

      if (!mounted) return;
      // 3) ...show the same message on the screen with our core widget...
      AppSnackBar.show(context, result.message, isSuccess: true);
      // 4) ...then REPLACE the camera with the result screen, so pressing back
      //    from the result returns to Home instead of the live camera.
      Navigator.pushReplacementNamed(
        context,
        RoutesManager.result,
        arguments: result.id,
      );
    } on ServerException catch (e) {
      // 5) The server said no -> show the message.
      print('❌ Upload failed: ${e.errModel.errorMessage}');
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      // 6) Always stop the loading spinner.
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: _capturedImage != null
          ? Stack(
        children: [
          SizedBox.expand(
            child: Image.file(
              File(_capturedImage!.path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: _retakePicture,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(_capturedImage!.path),
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: _confirmPicture,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
          // A simple loading overlay while the photo is being uploaded.
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      )
          : Stack(
        children: [
          SizedBox.expand(
            child: CameraPreview(_controller!),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}