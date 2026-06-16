import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
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
  });

  final String title;
  final String date;
  final DocumentType type;
  final double iconSize;
  final bool showFavoriteButton;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _icon,
              color: colorScheme.onSurface.withOpacity(0.5),
              size: widget.iconSize,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.date,
                  style: GoogleFonts.inter(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutesManager.result),
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
    );
  }
}