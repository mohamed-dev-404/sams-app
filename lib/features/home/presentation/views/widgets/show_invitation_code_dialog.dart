import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class ShowInvitationCodeDialog extends StatefulWidget {
  const ShowInvitationCodeDialog({super.key, required this.invitationCode});

  final String invitationCode;

  @override
  State<ShowInvitationCodeDialog> createState() =>
      _ShowInvitationCodeDialogState();
}

class _ShowInvitationCodeDialogState extends State<ShowInvitationCodeDialog> {
  bool isCopied = false;
 

  void _handleCopy() {
    Clipboard.setData(ClipboardData(text: widget.invitationCode));
    setState(() {
      isCopied = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Course Invitation Code',
        textAlign: TextAlign.center,
        style: AppStyles.mobileTitleMediumSb.copyWith(
          color: AppColors.primaryDarkHover,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.8,
            child: Text(
              'Students can join using the code below',
              style: AppStyles.mobileBodyMediumRg.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCopied ? AppColors.secondary : AppColors.primary,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.invitationCode,
                  style: AppStyles.mobileTitleSmallSb.copyWith(
                    color: AppColors.primaryDarkHover,
                  ),
                ),
                InkWell(
                  onTap: _handleCopy,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isCopied
                          ? AppColors.secondary
                          : AppColors.primaryDarkHover,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isCopied ? Icons.check_rounded : Icons.copy_all_rounded,
                      color: AppColors.whiteLight,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isCopied) ...[
            const SizedBox(height: 8),
            Text(
              'Copied!',
              style: AppStyles.mobileBodyMediumRg.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
