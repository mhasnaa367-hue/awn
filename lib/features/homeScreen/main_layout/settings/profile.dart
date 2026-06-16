import 'package:awn/core/routesManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/widget/Appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = "Eman Hesham";
  String _email = "eh123@gmail.com";
  bool _isDark = false;

  void _editField(String label, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit $label"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter your $label"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Appbar(title: "Profile"),
          const SizedBox(height: 60),
          SvgPicture.asset(AssetsManager.prof, width: 120),
          const SizedBox(height: 16),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _name,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => _editField("Name", _name, (val) {
                  setState(() => _name = val);
                }),
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _email,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => _editField("Email", _email, (val) {
                  setState(() => _email = val);
                }),
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _OptionCard(
                  icon: Icons.language,
                  label: "Language",
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _OptionCard(
                  icon: Icons.dark_mode_outlined,
                  label: "Dark",
                  trailing: Switch(
                    value: _isDark,
                    onChanged: (val) => setState(() => _isDark = val),
                    activeColor: ColorsManager.green,
                  ),
                ),
                const SizedBox(height: 12),
                _OptionCard(
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  label: "Log Out",
                  trailing: Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesManager.loginsrceen);
                  },
                ),
              ],
            ),
          ),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
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