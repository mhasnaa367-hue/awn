import 'package:awn/core/API/document_setup.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/providers/user_provider.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/app_drawer.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Our ready-to-use document repository (built by the helper).
  final DocumentRepository _documents = createDocumentRepository();

  bool _isUploading = false; // true while we send the file to the server

  @override
  void initState() {
    super.initState();
    // Fetch the user once and cache it for the whole app (drawer, profile...).
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<UserProvider>().ensureLoaded(),
    );
  }

  // Sends one picked file to the server and reacts to the result.
  Future<void> _uploadDocument(String filePath) async {
    setState(() => _isUploading = true);
    try {
      // 1) Call the upload API.
      final result = await _documents.uploadDocument(filePath: filePath);

      // 2) Success -> print the message in the terminal...
      print('✅ Upload success: ${result.message}');
      print('   document id: ${result.id}, status: ${result.status}');

      if (!mounted) return;
      // 3) ...show the same message on the screen with our core widget...
      AppSnackBar.show(context, result.message, isSuccess: true);
      // 4) ...then open the result screen for this document (it polls + loads).
      Navigator.pushNamed(context, RoutesManager.result, arguments: result.id);
    } on ServerException catch (e) {
      // 5) The server said no (not verified, too big, ...) -> show the message.
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
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          SafeArea(
            child: ResponsiveCenter(
              maxWidth: 640,
              padding: EdgeInsets.symmetric(
                  vertical: context.hp(2), horizontal: context.wp(4)),
              child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.list,
                    size: context.r(30),
                    color: colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      context.watch<UserProvider>().name.isEmpty
                          ? l.hiUser
                          : l.greeting(context.watch<UserProvider>().name),
                      style: GoogleFonts.inter(
                        fontSize: context.sp(24),
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : ColorsManager.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.r(30)),
              ],
            ),
            Column(
              children: [
                Text(
                  l.readyToLearn,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : ColorsManager.lightgray,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.hp(14)),
            _ActionCard(
              icon: Icons.camera_alt_outlined,
              title: l.scanPage,
              subtitle: l.scanPageSubtitle,
              onTap: () {
                Navigator.pushNamed(context, RoutesManager.camera);
              },
            ),
            SizedBox(height: context.hp(1.8)),
            _ActionCard(
              icon: Icons.upload_outlined,
              title: l.uploadFile,
              subtitle: l.uploadFileSubtitle,
              onTap: () async {
                // file_picker opens the system document picker, which grants
                // temporary read access to the chosen file — no runtime storage
                // permission is needed (and Permission.storage is denied on
                // Android 13+, which used to block this whole flow).
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                );

                if (result != null) {
                  final filePath = result.files.single.path;
                  if (filePath != null) {
                    await _uploadDocument(filePath);
                  }
                }
              },
            ),
          ],
              ),
            ),
          ),
          // A simple loading overlay while the file is being uploaded.
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: context.hp(3.2), horizontal: context.wp(5)),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: context.r(36),
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            SizedBox(height: context.hp(1.4)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: context.sp(16),
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: context.hp(0.5)),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: context.sp(13),
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}