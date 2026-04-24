import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/shared/general_arrow_back.dart';

class AssignmentSubmissionDetailsMobileLayout extends StatelessWidget {
  const AssignmentSubmissionDetailsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF158A9E),
      body: Column(
        children: [
          /// 🔹 Header
          const ProfileHeader(),

          /// 🔹 Bottom Container
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Documents',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),

                  const AnimatedDocumentCard(
                    title: 'Assignment PDF',
                    subtitle: 'Tap to open document',
                    type: 'PDF',
                    icon: Icons.picture_as_pdf,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () {
                      _showSimilarityDialog(context);
                    },
                    child: const AnimatedDocumentCard(
                      title: 'Similarity Report',
                      subtitle: 'Preview plagiarism check',
                      type: 'View',
                      icon: Icons.search,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Decision',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  const DecisionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSimilarityDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SimilarityItem(
                percentage: 10,
                text: "Nadia's assignment is similar to Mariam's",
              ),
              SizedBox(height: 12),
              SimilarityItem(
                percentage: 80,
                text: "Nadia's assignment is similar to Mariam's",
              ),
              SizedBox(height: 12),
              SimilarityItem(
                percentage: 20,
                text: "Nadia's assignment is similar to Mariam's",
              ),
            ],
          ),
        ),
      );
    },
  );
}

class SimilarityItem extends StatelessWidget {
  final int percentage;
  final String text;

  const SimilarityItem({
    super.key,
    required this.percentage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = percentage / 100;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          /// 🔥 Circular Percentage
          CircularPercentIndicator(
            radius: 28,
            lineWidth: 5,
            percent: percent,
            center: Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: Colors.orange,
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
          ),

          const SizedBox(width: 12),

          /// Text
          Expanded(
            child: Text(
              '$text with $percentage percent',
              style: const TextStyle(fontSize: 13),
            ),
          ),

          /// Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Preview',
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Column(
        children: [
          /// Top Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const GeneralArrowBack(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 40),
                const Text(
                  'Student Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Avatar
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Text(
              'MM',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          const SizedBox(height: 12),

          /// Name
          const Text(
            'Nadia Ashraf Mohamed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          /// ID
          const Text(
            'ID: 202231231',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedDocumentCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String type;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const AnimatedDocumentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  State<AnimatedDocumentCard> createState() => _AnimatedDocumentCardState();
}

class _AnimatedDocumentCardState extends State<AnimatedDocumentCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),

        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),

          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                /// Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: widget.color),
                ),
                const SizedBox(width: 12),

                /// Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.type,
                    style: TextStyle(color: widget.color, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedDecisionButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback? onTap;

  const AnimatedDecisionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.onTap,
  });

  @override
  State<AnimatedDecisionButton> createState() => _AnimatedDecisionButtonState();
}

class _AnimatedDecisionButtonState extends State<AnimatedDecisionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.03 : 1.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.color),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),

        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: widget.bgColor,
                  child: Icon(widget.icon, color: widget.color),
                ),
                const SizedBox(height: 8),
                Text(widget.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DecisionButtons extends StatelessWidget {
  const DecisionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedDecisionButton(
            text: "Accept",
            icon: Icons.check,
            color: Colors.teal,
            bgColor: const Color(0xFFE8F5F2),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AnimatedDecisionButton(
            text: "Reject",
            icon: Icons.close,
            color: Colors.red,
            bgColor: const Color(0xFFFDECEC),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
