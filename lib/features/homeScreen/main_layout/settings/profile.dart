import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/language_provider.dart';
import 'package:awn/core/providers/user_provider.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/user_avatar.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/widget/Appbar.dart';
import 'package:awn/config/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthRepository _auth = createAuthRepository();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<UserProvider>().ensureLoaded(),
    );
  }

  // Let the user pick a profile picture from the camera or gallery.
  Future<void> _pickAvatar() async {
    final l = AppLocalizations.of(context)!;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l.scanPage),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l.uploadFile),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 80);
      if (picked == null || !mounted) return;
      await context.read<UserProvider>().setLocalAvatar(picked.path);
      if (!mounted) return;
      AppSnackBar.show(context, l.profileUpdated, isSuccess: true);
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, l.loadFailed, isSuccess: false);
    }
  }

  Future<void> _editName() async {
    final l = AppLocalizations.of(context)!;
    final users = context.read<UserProvider>();
    final controller = TextEditingController(text: users.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("${l.edit} ${l.editName}"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: l.editName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l.save),
          ),
        ],
      ),
    );

    if (newName == null || newName.isEmpty || newName == users.name) return;
    try {
      await users.updateName(newName);
      if (!mounted) return;
      AppSnackBar.show(context, l.profileUpdated, isSuccess: true);
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    }
  }

  Future<void> _changePassword() async {
    final l = AppLocalizations.of(context)!;
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.changePassword),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: currentCtrl,
                obscureText: true,
                decoration: InputDecoration(hintText: l.currentPassword),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l.enterPassword : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: newCtrl,
                obscureText: true,
                decoration: InputDecoration(hintText: l.newPassword),
                validator: (v) =>
                    (v == null || v.length < 8) ? l.passwordMin8 : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: Text(l.save),
          ),
        ],
      ),
    );

    if (ok != true) return;
    try {
      await _auth.changePassword(
        currentPassword: currentCtrl.text,
        newPassword: newCtrl.text,
      );
      if (!mounted) return;
      await context.read<UserProvider>().clear();
      if (!mounted) return;
      AppSnackBar.show(context, l.passwordChanged, isSuccess: true);
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesManager.loginsrceen, (route) => false);
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    }
  }

  Future<void> _logout() async {
    try {
      await _auth.logout();
    } catch (_) {
      // Local session is cleared regardless of the network result.
    }
    if (!mounted) return;
    await context.read<UserProvider>().clear();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesManager.loginsrceen, (route) => false);
  }

  void _showLanguageDialog(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("العربية"),
              leading: const Icon(Icons.language),
              onTap: () {
                context.read<LanguageProvider>().setLanguage('ar');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("English"),
              leading: const Icon(Icons.language),
              onTap: () {
                context.read<LanguageProvider>().setLanguage('en');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final users = context.watch<UserProvider>();

    return Scaffold(
      body: SafeArea(
        child: (!users.isLoaded && users.isLoading)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: ResponsiveCenter(
                  maxWidth: 560,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Appbar(title: l.profile),
                      SizedBox(height: context.hp(4)),
                      UserAvatar(
                        radius: context.r(56),
                        showCameraBadge: true,
                        onTap: _pickAvatar,
                      ),
                      SizedBox(height: context.hp(2)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              users.name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: context.sp(18),
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: _editName,
                            child: Icon(
                              Icons.edit,
                              size: context.r(18),
                              color: colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.hp(0.5)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              users.email,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: context.sp(14),
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            users.isVerified
                                ? Icons.verified
                                : Icons.error_outline,
                            size: context.r(16),
                            color: users.isVerified
                                ? ColorsManager.green
                                : ColorsManager.red,
                          ),
                        ],
                      ),
                      SizedBox(height: context.hp(4)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.wp(5)),
                        child: Column(
                          children: [
                            if (!users.isVerified)
                              _OptionCard(
                                icon: Icons.mark_email_read_outlined,
                                iconColor: ColorsManager.green,
                                label: l.verifyEmailTitle,
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, RoutesManager.verifyEmail),
                              ),
                            if (!users.isVerified)
                              SizedBox(height: context.hp(1.5)),
                            _OptionCard(
                              icon: Icons.lock_outline,
                              label: l.changePassword,
                              trailing: Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                              onTap: _changePassword,
                            ),
                            SizedBox(height: context.hp(1.5)),
                            _OptionCard(
                              icon: Icons.language,
                              label: l.language,
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                              onTap: () => _showLanguageDialog(context),
                            ),
                            SizedBox(height: context.hp(1.5)),
                            _OptionCard(
                              icon: Icons.dark_mode_outlined,
                              label: l.dark,
                              trailing: Consumer<ThemeProvider>(
                                builder: (context, themeProvider, _) {
                                  return Switch(
                                    value: themeProvider.isDark,
                                    onChanged: (val) =>
                                        themeProvider.toggleTheme(),
                                    activeColor: ColorsManager.green,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: context.hp(1.5)),
                            _OptionCard(
                              icon: Icons.logout,
                              iconColor: Colors.red,
                              label: l.logOut,
                              trailing: Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                              onTap: _logout,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.hp(3)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;
  final Color iconColor;

  const _OptionCard({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.wp(4), vertical: context.hp(1.8)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: context.r(22)),
            SizedBox(width: context.wp(3)),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: context.sp(15),
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
