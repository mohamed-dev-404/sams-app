import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assiment_model.dart';
import 'package:sams_app/features/assignments/data/model/helper/assiment_status_enum.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_card_image.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_card_style.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_status_badge.dart';
import 'package:sams_app/features/assignments/presentation/view/assiment_tap_view/widget/shared/assiment_trailing_icon.dart';

class WebAssignmentCard extends StatefulWidget {
  final AssignmentModel assignment;
  final VoidCallback onTap;

  const WebAssignmentCard({
    super.key,
    required this.assignment,
    required this.onTap,
  });

  @override
  State<WebAssignmentCard> createState() => _WebAssignmentCardState();
}

class _WebAssignmentCardState extends State<WebAssignmentCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final style = AssignmentCardStyle.fromState(widget.assignment.state);
    final bool isClosed = widget.assignment.state == AssignmentState.closed;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: isClosed ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isClosed ? null : widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered
                  ? style.titleColor.withValues(alpha: 0.3)
                  : style.borderColor,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 16,
                right: 16,
                child: AssignmentTrailingIcon(
                  state: widget.assignment.state,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.sp,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        transform: Matrix4.identity()
                          ..translateByDouble(
                            0,
                            isClosed
                                ? 0
                                : isHovered
                                ? -5
                                : 0,
                            0,
                            1,
                          ),
                        child: AssignmentCardImage(
                          state: widget.assignment.state,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.assignment.title,
                      style: AppStyles.mobileTitleSmallSb.copyWith(
                        fontSize: 18,
                        color: style.titleColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          widget.assignment.description.isEmpty
                              ? 'No description available'
                              : widget.assignment.description,
                          style: AppStyles.mobileBodySmallRg.copyWith(
                            fontSize: 13,
                            color: style.descriptionColor.withValues(
                              alpha: 0.8,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: AssignmentStatusBadge(
                        state: widget.assignment.state,
                        formattedDueDate: widget.assignment.formattedDueDate,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
