import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/classwork_item_model.dart';

/// A tap-able field that looks like a text input but opens a bottom-sheet
/// selector for choosing a [ClassworItemkModel].
///
/// Design: Rounded border, teal/primary colour scheme, trailing chevron icon,
/// matching the overall Create Quiz aesthetic.
class ClassworkSelectorField extends StatelessWidget {
  final ClassworItemkModel? selectedClasswork;
  final List<ClassworItemkModel> classworkItems;
  final ValueChanged<ClassworItemkModel> onSelected;

  const ClassworkSelectorField({
    super.key,
    required this.selectedClasswork,
    required this.classworkItems,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => _showClassworkSheet(context),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: 'Select assigned classwork',
          hintStyle: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.whiteDarkHover,
          ),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryDark,
          ),
        ),
        child: selectedClasswork != null
            ? Text(
                '${selectedClasswork!.name}  •  ${selectedClasswork!.points} pts',
                style: AppStyles.mobileBodySmallMd.copyWith(
                  color: AppColors.primaryDarkHover,
                ),
              )
            : null,
      ),
    );
  }

  // ──────────────── Bottom Sheet ────────────────

  void _showClassworkSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return _ClassworkSelectionSheet(
          items: classworkItems,
          selectedId: selectedClasswork?.id,
          onSelected: (item) {
            onSelected(item);
            Navigator.of(sheetContext).pop();
          },
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  Private Bottom-Sheet Content
// ══════════════════════════════════════════════════════════════

class _ClassworkSelectionSheet extends StatelessWidget {
  final List<ClassworItemkModel> items;
  final String? selectedId;
  final ValueChanged<ClassworItemkModel> onSelected;

  const _ClassworkSelectionSheet({
    required this.items,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Handle bar ──
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.whiteActive,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),

            // ── Title ──
            Text(
              'Select Classwork',
              style: AppStyles.mobileTitleSmallSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.whiteHover, thickness: 1),
            const SizedBox(height: 4),

            // ── Items ──
            ...items.map((item) {
              final bool isSelected = item.id == selectedId;
              return _ClassworkTile(
                item: item,
                isSelected: isSelected,
                onTap: () => onSelected(item),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  Single Tile
// ══════════════════════════════════════════════════════════════

class _ClassworkTile extends StatelessWidget {
  final ClassworItemkModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClassworkTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryLight
              : AppColors.whiteLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.secondary
                : AppColors.whiteHover,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.secondary
                      : AppColors.whiteDarkHover,
                  width: 2,
                ),
                color: isSelected
                    ? AppColors.secondary
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),

            // Name & points
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppStyles.mobileBodySmallMd.copyWith(
                      color: isSelected
                          ? AppColors.primaryDarkHover
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.points} points',
                    style: AppStyles.mobileBodyXsmallRg.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
