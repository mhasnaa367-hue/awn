import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';

enum DocumentType { camera, image, pdf, file }

class DocumentCard extends StatefulWidget {
  const DocumentCard({
    super.key,
    required this.title,
    required this.date,
    required this.type,
    this.iconSize = 25,
    this.showFavoriteButton = false,
    this.onTap,
    this.onDelete,
  });

  final String title;
  final String date;
  final DocumentType type;
  final double iconSize;
  final bool showFavoriteButton;

  // If provided, tapping the card runs this instead of the default navigation.
  final VoidCallback? onTap;

  // If provided, a delete button is shown that runs this callback.
  final VoidCallback? onDelete;

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  IconData get _icon {
    switch (widget.type) {
      case DocumentType.camera: return Icons.camera_alt_outlined;
      case DocumentType.image:  return Icons.image_outlined;
      case DocumentType.pdf:    return Icons.picture_as_pdf_outlined;
      case DocumentType.file:   return Icons.description_outlined;
    }
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      Navigator.pushNamed(context, RoutesManager.result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final box = context.r(50).clamp(44.0, 64.0);

    return InkWell(
      onTap: _handleTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: context.wp(4), vertical: context.hp(1.6)),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: box,
              height: box,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _icon,
                color: colorScheme.onSurface.withOpacity(0.5),
                size: context.r(widget.iconSize),
              ),
            ),
            SizedBox(width: context.wp(2.5)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: colorScheme.onSurface,
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: context.hp(0.4)),
                  Text(
                    widget.date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: colorScheme.onSurface.withOpacity(0.5),
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.onDelete != null)
              IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: ColorsManager.red.withOpacity(0.8),
                ),
              )
            else
              IconButton(
                onPressed: _handleTap,
                icon: Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            if (widget.showFavoriteButton)
              Consumer<FavoritesProvider>(
                builder: (context, provider, _) {
                  final isFav = provider.isFavorite(widget.title);
                  return GestureDetector(
                    onTap: () {
                      if (isFav) {
                        provider.removeFavorite(widget.title);
                      } else {
                        provider.addFavorite(FavoriteItem(
                          title: widget.title,
                          date: widget.date,
                          type: widget.type,
                        ));
                      }
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                         color: isFav
                            ? ColorsManager.green
                            : colorScheme.onSurface.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
