import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/submission_details_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/grading_input_score_field.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/mcq_options_list.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/written_answer.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/grading_cubit/grading_cubit.dart';

class GradeSubmissionWebLayout extends StatefulWidget {
  final String submissionId;

  const GradeSubmissionWebLayout({super.key, required this.submissionId});

  @override
  State<GradeSubmissionWebLayout> createState() =>
      _GradeSubmissionWebLayoutState();
}

class _GradeSubmissionWebLayoutState extends State<GradeSubmissionWebLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradingCubit, GradingState>(
      builder: (context, state) {
        // ── Loading ───────────────────────────────────────────────────────
        if (state is GradingLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFF4F6F9),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ── Failure ───────────────────────────────────────────────────────
        if (state is GradingFailure) {
          return Scaffold(
            backgroundColor: const Color(0xFFF4F6F9),
            body: Center(child: Text(state.errorMessage)),
          );
        }

        // ── Data ready ────────────────────────────────────────────────────
        if (state is GradingLoaded || state is GradingQuestionSaving) {
          final questions = state is GradingLoaded
              ? state.questions
              : (state as GradingQuestionSaving).questions;

          // Clamp selected index if questions shrink
          if (_selectedIndex >= questions.length) {
            _selectedIndex = questions.length - 1;
          }

          final selected = questions[_selectedIndex];

          return Scaffold(
            backgroundColor: const Color(0xFFF4F6F9),
            body: Row(
              children: [
                // ── Left Panel: Question Navigator ──────────────────────
                _LeftSidePanel(
                  questions: questions,
                  selectedIndex: _selectedIndex,
                  onSelect: (i) => setState(() => _selectedIndex = i),
                ),

                // ── Center Panel: Question Detail ───────────────────────
                Expanded(
                  child: _CenterPanel(
                    key: ValueKey(selected.id),
                    question: selected,
                    questionIndex: _selectedIndex,
                    totalCount: questions.length,
                    onPrev: _selectedIndex > 0
                        ? () => setState(() => _selectedIndex--)
                        : null,
                    onNext: _selectedIndex < questions.length - 1
                        ? () => setState(() => _selectedIndex++)
                        : null,
                  ),
                ),

                // ── Right Panel: Grading Action ─────────────────────────
                _RightGradingPanel(
                  question: selected,
                  submissionId: widget.submissionId,
                  questions: questions,
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 📋 LEFT PANEL — Question Navigator
// ═══════════════════════════════════════════════════════════════════════════
class _LeftSidePanel extends StatelessWidget {
  final List<SubmissionDetailsModel> questions;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _LeftSidePanel({
    required this.questions,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Count stats
    final total = questions.length;
    final graded = questions.where((q) => q.isGraded || !q.isWritten).length;
    final pending = total - graded;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border(
          right: BorderSide(
            color: AppColors.secondaryLightActive.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Questions',
                      style: AppStyles.webAgBodyBold.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : graded / total,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$graded / $total graded',
                      style: AppStyles.webAgBodyRegular.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 11,
                      ),
                    ),
                    if (pending > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: StatusColors.orange.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '$pending pending',
                          style: AppStyles.webAgBodyRegular.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Question list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: questions.length,
              itemBuilder: (_, i) => _QuestionNavItem(
                question: questions[i],
                index: i,
                isSelected: i == selectedIndex,
                onTap: () => onSelect(i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Single nav row ──────────────────────────────────────────────────────────
class _QuestionNavItem extends StatelessWidget {
  final SubmissionDetailsModel question;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuestionNavItem({
    required this.question,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    IconData dotIcon;

    if (question.isWritten) {
      dotColor = question.isGraded ? StatusColors.green : StatusColors.orange;
      dotIcon = question.isGraded
          ? Icons.check_circle_rounded
          : Icons.radio_button_unchecked_rounded;
    } else {
      final correct = question.isCorrect ?? false;
      dotColor = correct ? StatusColors.green : StatusColors.red;
      dotIcon = correct ? Icons.check_circle_rounded : Icons.cancel_rounded;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.secondaryLightActive,
            ),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: AppStyles.webAgBodyBold.copyWith(
                fontSize: 11,
                color: isSelected ? Colors.white : AppColors.primaryDark,
              ),
            ),
          ),
        ),
        title: Text(
          question.text.length > 40
              ? '${question.text.substring(0, 40)}…'
              : question.text,
          style: AppStyles.webAgBodyRegular.copyWith(
            fontSize: 12,
            color: isSelected ? AppColors.primaryDark : AppColors.whiteDarker,
          ),
          maxLines: 2,
        ),
        trailing: Icon(dotIcon, color: dotColor, size: 16),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 📄 CENTER PANEL — Question Detail
// ═══════════════════════════════════════════════════════════════════════════
class _CenterPanel extends StatelessWidget {
  final SubmissionDetailsModel question;
  final int questionIndex;
  final int totalCount;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _CenterPanel({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.totalCount,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar
        _buildTopBar(context),

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question header badges
                _buildBadgesRow(),
                const SizedBox(height: 24),

                // Question text
                Text(
                  question.text,
                  style: AppStyles.webAgBodyBold.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryDarkActive,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 28),

                // Divider
                Divider(
                  color: AppColors.secondaryLightActive.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 20),

                // Student Answer section label
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 16,
                      color: AppColors.whiteDarkActive,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'STUDENT ANSWER',
                      style: AppStyles.webAgBodyBold.copyWith(
                        fontSize: 10,
                        color: AppColors.whiteDarkActive,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Answer body
                if (question.isWritten)
                  WrittenAnswer(answer: question.writtenAnswer)
                else if (question.options != null)
                  McqOptionsList(options: question.options!),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),

        // Bottom nav
        _buildBottomNav(),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondaryLightActive.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Question ${questionIndex + 1} of $totalCount',
            style: AppStyles.webAgBodyBold.copyWith(
              fontSize: 13,
              color: AppColors.primaryDark,
            ),
          ),
          const Spacer(),
          _StateChip(question: question),
        ],
      ),
    );
  }

  Widget _buildBadgesRow() {
    final bool isWritten = question.isWritten;
    final Color typeColor = isWritten ? AppColors.primary : AppColors.secondary;
    final IconData typeIcon = isWritten
        ? Icons.description_outlined
        : Icons.fact_check_outlined;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Type badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: typeColor.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: typeColor.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(typeIcon, size: 13, color: typeColor),
              const SizedBox(width: 6),
              Text(
                question.uiTypeLabel.toUpperCase(),
                style: AppStyles.webAgBodyBold.copyWith(
                  fontSize: 10,
                  color: typeColor,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),

        // Points badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Text(
            '${question.points} pts',
            style: AppStyles.webAgBodyBold.copyWith(
              fontSize: 10,
              color: AppColors.primary,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border(
          top: BorderSide(
            color: AppColors.secondaryLightActive.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prev
          TextButton.icon(
            onPressed: onPrev,
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 14),
            label: const Text('Previous'),
            style: TextButton.styleFrom(
              foregroundColor: onPrev != null
                  ? AppColors.primaryDark
                  : AppColors.whiteDark,
            ),
          ),

          // Dot indicators (max 8 shown)
          _DotIndicator(
            total: totalCount,
            current: questionIndex,
          ),

          // Next
          TextButton.icon(
            onPressed: onNext,
            icon: const Text('Next'),
            label: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
            style: TextButton.styleFrom(
              foregroundColor: onNext != null
                  ? AppColors.primaryDark
                  : AppColors.whiteDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ── State chip (MARKED / UNMARKED / CORRECT / INCORRECT) ───────────────────
class _StateChip extends StatelessWidget {
  final SubmissionDetailsModel question;
  const _StateChip({required this.question});

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String label;
    final IconData icon;

    switch (question.state) {
      case QuestionUIState.correct:
        color = StatusColors.green;
        label = 'CORRECT';
        icon = Icons.check_circle_rounded;
        break;
      case QuestionUIState.incorrect:
        color = StatusColors.red;
        label = 'INCORRECT';
        icon = Icons.cancel_rounded;
        break;
      case QuestionUIState.marked:
        color = AppColors.primary;
        label = 'MARKED';
        icon = Icons.done_all_rounded;
        break;
      case QuestionUIState.unmarked:
        color = StatusColors.orange;
        label = 'PENDING';
        icon = Icons.schedule_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppStyles.webAgBodyBold.copyWith(
              fontSize: 11,
              color: color,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dot indicators ──────────────────────────────────────────────────────────
class _DotIndicator extends StatelessWidget {
  final int total;
  final int current;
  const _DotIndicator({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    final int show = total.clamp(0, 10);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(show, (i) {
        final bool active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.secondaryLightActive,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ✏️ RIGHT PANEL — Grading Action Panel
// ═══════════════════════════════════════════════════════════════════════════
class _RightGradingPanel extends StatelessWidget {
  final SubmissionDetailsModel question;
  final String submissionId;
  final List<SubmissionDetailsModel> questions;

  const _RightGradingPanel({
    required this.question,
    required this.submissionId,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final int gradedCount = questions
        .where((q) => q.isGraded || !q.isWritten)
        .length;
    final int totalPoints = questions.fold(0, (sum, q) => sum + q.points);
    final int earnedPoints = questions.fold(
      0,
      (sum, q) => sum + q.earnedPoints,
    );
    final double progressValue = totalPoints == 0
        ? 0
        : earnedPoints / totalPoints;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border(
          left: BorderSide(
            color: AppColors.secondaryLightActive.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(-2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.secondaryLightActive.withValues(alpha: 0.4),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.grading_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Grading',
                      style: AppStyles.webAgBodyBold.copyWith(
                        fontSize: 14,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Score summary card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryLight,
                        AppColors.secondaryLight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Score',
                            style: AppStyles.webAgBodyRegular.copyWith(
                              fontSize: 12,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          Text(
                            '$earnedPoints / $totalPoints pts',
                            style: AppStyles.webAgBodyBold.copyWith(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.12,
                          ),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          minHeight: 5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$gradedCount/${questions.length} reviewed',
                            style: AppStyles.webAgBodyRegular.copyWith(
                              fontSize: 11,
                              color: AppColors.whiteDarkActive,
                            ),
                          ),
                          Text(
                            '${(progressValue * 100).toStringAsFixed(0)}%',
                            style: AppStyles.webAgBodyBold.copyWith(
                              fontSize: 11,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Grading action area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Only show input for written questions
                  if (question.isWritten) ...[
                    Text(
                      'ASSIGN SCORE',
                      style: AppStyles.webAgBodyBold.copyWith(
                        fontSize: 10,
                        color: AppColors.whiteDarkActive,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Reuse the existing mobile GradingInputScoreField
                    BlocBuilder<GradingCubit, GradingState>(
                      builder: (context, state) {
                        final isSavingThis =
                            state is GradingQuestionSaving &&
                            state.savingQuestionId == question.id;
                        return GradingInputScoreField(
                          question: question,
                          isSaving: isSavingThis,
                          onSave: (score) {
                            context.read<GradingCubit>().gradeQuestion(
                              submissionId: submissionId,
                              questionId: question.id,
                              score: score,
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                  ],

                  // MCQ/TF: show auto-grade summary
                  if (!question.isWritten) ...[
                    _AutoGradeInfo(question: question),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                  ],

                  // Rubric / Notes area (placeholder — ready for API)
                  Text(
                    'INSTRUCTOR NOTE',
                    style: AppStyles.webAgBodyBold.copyWith(
                      fontSize: 10,
                      color: AppColors.whiteDarkActive,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.secondaryLightActive.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    child: TextField(
                      maxLines: 4,
                      style: AppStyles.webAgBodyRegular.copyWith(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Add a note for this question (optional)...',
                        hintStyle: AppStyles.webAgBodyRegular.copyWith(
                          fontSize: 12,
                          color: AppColors.whiteDark,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Auto-grade info card for MCQ / TF ──────────────────────────────────────
class _AutoGradeInfo extends StatelessWidget {
  final SubmissionDetailsModel question;
  const _AutoGradeInfo({required this.question});

  @override
  Widget build(BuildContext context) {
    final bool correct = question.isCorrect ?? false;
    final color = correct ? StatusColors.green : StatusColors.red;
    final icon = correct ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final label = correct ? 'Correct Answer' : 'Wrong Answer';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppStyles.webAgBodyBold.copyWith(
                  fontSize: 12,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Auto-graded: ${question.earnedPoints} / ${question.points} pts',
            style: AppStyles.webAgBodyRegular.copyWith(
              fontSize: 12,
              color: AppColors.primaryDarkActive,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'MCQ and True/False questions are graded automatically.',
            style: AppStyles.webAgBodyRegular.copyWith(
              fontSize: 11,
              color: AppColors.whiteDarkActive,
            ),
          ),
        ],
      ),
    );
  }
}
