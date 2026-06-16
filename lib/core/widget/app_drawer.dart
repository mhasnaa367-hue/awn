import 'package:awn/core/routesManager.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _activeItem = 'Home';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorsManager.green,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      l.hiEman,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l.learnSmarter,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/100?img=11',
                  ),
                ),
              ],
            ),
          ),

          _buildNavItem(icon: Icons.home, label: l.home, key: 'Home'),
          _buildNavItem(icon: Icons.favorite_border_outlined, label: l.favoritesList, key: 'Favorites'),
          _buildNavItem(icon: Icons.history, label: l.historyList, key: 'History'),
          _buildNavItem(icon: Icons.account_circle_outlined, label: l.profileLabel, key: 'Profile'),

          const Spacer(),
          Divider(color: colorScheme.outline.withOpacity(0.3)),

          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                RoutesManager.loginsrceen,
              );
            },
            child: Text(
              l.logOutUpper,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required String key,
  }) {
    final isActive = _activeItem == key;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      tileColor: isActive ? ColorsManager.green.withOpacity(0.1) : null,
      leading: Icon(
        icon,
        color: isActive
            ? ColorsManager.green
            : colorScheme.onSurface.withOpacity(0.5),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? ColorsManager.green : colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          _activeItem = key;
        });

        Navigator.pop(context);

        if (key == 'Home') {
          Navigator.pushNamed(context, RoutesManager.homeScreen);
        } else if (key == 'Favorites') {
          Navigator.pushNamed(context, RoutesManager.favorite);
        } else if (key == 'History') {
          Navigator.pushNamed(context, RoutesManager.history);
        } else if (key == 'Profile') {
          Navigator.pushNamed(context, RoutesManager.profile);
        }
      },
    );
  }
}