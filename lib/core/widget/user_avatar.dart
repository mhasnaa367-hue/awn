// One avatar widget used by both the Profile screen and the drawer, so the
// picked picture shows consistently. Priority:
//   1) the picture the user picked from the phone (local file)
//   2) the avatar URL from the server (if any)
//   3) a fallback circle with the user's first initial
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:awn/core/providers/user_provider.dart';
import 'package:awn/core/resources/colors_manager.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.radius,
    this.onTap,
    this.showCameraBadge = false,
  });

  final double radius;
  final VoidCallback? onTap;
  final bool showCameraBadge;

  @override
  Widget build(BuildContext context) {
    final up = context.watch<UserProvider>();

    ImageProvider? image;
    final local = up.localAvatarPath;
    final remote = up.user?.avatar;
    if (local != null && local.isNotEmpty && File(local).existsSync()) {
      image = FileImage(File(local));
    } else if (remote != null && remote.isNotEmpty) {
      image = NetworkImage(remote);
    }

    final initial = up.name.isNotEmpty ? up.name[0].toUpperCase() : '?';

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: image,
      child: image == null
          ? Text(
              initial,
              style: TextStyle(
                color: ColorsManager.green,
                fontSize: radius * 0.8,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );

    if (showCameraBadge) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorsManager.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(Icons.camera_alt,
                  color: Colors.white, size: radius * 0.28),
            ),
          ),
        ],
      );
    }

    if (onTap == null) return avatar;
    return GestureDetector(onTap: onTap, child: avatar);
  }
}
