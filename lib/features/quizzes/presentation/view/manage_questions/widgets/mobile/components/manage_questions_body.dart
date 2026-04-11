import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/model/editable_question_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/model/manage_questions_args.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/model/quiz_mode.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/mobile/components/add_question_bottom_sheet.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/mobile/components/delete_question_dialog.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/mobile/components/manage_questions_bottom_bar.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/shared/empty_state_widget.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/shared/mode_configuration_header.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/shared/question_card.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/manage_quiz_cubit/manage_quiz_cubit.dart';

/// The central stateful body for managing questions locally in the UI.
///
/// Forks the [initialQuestions] from the API into a mutable local state.
/// Manipulates them via internal callbacks, then securely delegates the 
/// finalized list to [ManageQuestionsBottomBar].
class ManageQuestionsBody extends StatefulWidget {
  final List<EditableQuestionModel> initialQuestions;
  final ManageQuestionsArgs args;

  const ManageQuestionsBody({
    super.key,
    required this.initialQuestions,
    required this.args,
  });

  @override
  State<ManageQuestionsBody> createState() => _ManageQuestionsBodyState();
}

class _ManageQuestionsBodyState extends State<ManageQuestionsBody> {
  late List<EditableQuestionModel> _questions;

  @override
  void initState() {
    super.initState();
    // Forking internal mutable state from the initial API state
    _questions = List.from(widget.initialQuestions);
  }

  // ──────────── View-Managed List Updates ────────────

  void _addQuestion(String questionType) {
    setState(() {
      final EditableQuestionModel newQuestion;
      switch (questionType) {
        case ApiValues.written:
          newQuestion = EditableQuestionModel.written();
          break;
        case ApiValues.mcq:
          newQuestion = EditableQuestionModel.mcq();
          break;
        case ApiValues.trueFalse:
          newQuestion = EditableQuestionModel.trueFalse();
          break;
        default:
          return;
      }
      _questions = [..._questions, newQuestion];
    });
  }

  void _removeQuestion(String localId) {
    setState(() {
      _questions = _questions.where((q) => q.localId != localId).toList();
    });
  }

  void _updateQuestionField(
      String localId, {
      String? text,
      int? timeLimit,
      int? points,
      }) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != localId) return q;
        return q.copyWith(
          text: text,
          timeLimit: timeLimit,
          points: points,
        );
      }).toList();
    });
  }

  void _changeQuestionType(String localId, String newType) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != localId) return q;
        if (q.questionType == newType) return q;

        List<EditableOptionModel> newOptions;
        switch (newType) {
          case ApiValues.written:
            newOptions = [];
            break;
          case ApiValues.mcq:
            newOptions = [
              EditableOptionModel.empty(),
              EditableOptionModel.empty(),
            ];
            break;
          case ApiValues.trueFalse:
            newOptions = [
              EditableOptionModel.trueFalse(label: 'True', isCorrect: true),
              EditableOptionModel.trueFalse(label: 'False', isCorrect: false),
            ];
            break;
          default:
            newOptions = [];
        }

        return q.copyWith(questionType: newType, options: newOptions);
      }).toList();
    });
  }

  void _addOption(String questionLocalId) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != questionLocalId || !q.isMcq) return q;
        return q.copyWith(
          options: [...q.options, EditableOptionModel.empty()],
        );
      }).toList();
    });
  }

  void _removeOption(String questionLocalId, String optionLocalId) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != questionLocalId) return q;
        if (q.options.length <= 2) return q;
        return q.copyWith(
          options: q.options.where((o) => o.localId != optionLocalId).toList(),
        );
      }).toList();
    });
  }

  void _updateOptionText(
      String questionLocalId, String optionLocalId, String text) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != questionLocalId) return q;
        return q.copyWith(
          options: q.options.map((o) {
            if (o.localId != optionLocalId) return o;
            return o.copyWith(text: text);
          }).toList(),
        );
      }).toList();
    });
  }

  void _toggleCorrectOption(String questionLocalId, String optionLocalId) {
    setState(() {
      _questions = _questions.map((q) {
        if (q.localId != questionLocalId) return q;
        return q.copyWith(
          options: q.options.map((o) {
            if (o.localId == optionLocalId) return o.copyWith(isCorrect: true);
            return o.copyWith(isCorrect: false);
          }).toList(),
        );
      }).toList();
    });
  }

  // ──────────── Build Methods ────────────

  @override
  Widget build(BuildContext context) {
    final mode = widget.args.mode;
    final isReadOnly = mode == QuizMode.view;
    final canAddNew = mode == QuizMode.draft || mode == QuizMode.edit;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: isReadOnly
              ? null
              : ManageQuestionsBottomBar(
                  mode: mode,
                  questions: _questions,
                ),
          floatingActionButton:
              canAddNew && _questions.isNotEmpty ? _buildFab(context) : null,
          body: Column(
            children: [
              ModeConfigurationHeader(
                mode: mode,
                questionCount: _questions.length,
              ),
              Expanded(
                child: _questions.isEmpty
                    ? EmptyStateWidget(
                        onAddFirst: canAddNew
                            ? () => AddQuestionBottomSheet.show(
                                  context,
                                  onAdd: _addQuestion,
                                )
                            : null,
                      )
                    : _buildQuestionsList(),
              ),
            ],
          ),
        ),

        // Handle Action Loading Overlay locally so we don't lose widget state
        BlocBuilder<ManageQuizCubit, ManageQuizState>(
          builder: (context, state) {
            if (state is ManageQuizActionLoading) {
              return Container(
                color: Colors.white.withAlpha(120),
                child: const Center(
                  child: AppAnimatedLoadingIndicator(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildQuestionsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      itemCount: _questions.length,
      itemBuilder: (context, index) {
        final question = _questions[index];
        return QuestionCard(
          key: ValueKey(question.localId),
          question: question,
          mode: widget.args.mode,
          index: index,
          onRemove: widget.args.mode == QuizMode.edit && !question.isNew
              ? (localId) => _confirmDeleteServer(localId)
              : _removeQuestion,
          onUpdateField: _updateQuestionField,
          onChangeType: _changeQuestionType,
          onAddOption: _addOption,
          onRemoveOption: _removeOption,
          onUpdateOptionText: _updateOptionText,
          onToggleCorrectOption: _toggleCorrectOption,
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddQuestionBottomSheet.show(context, onAdd: _addQuestion),
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.add_rounded, color: Colors.white),
    );
  }

  void _confirmDeleteServer(String localId) {
    final serverId =
        _questions.firstWhere((q) => q.localId == localId).serverId;

    DeleteQuestionDialog.show(
      context,
      onConfirm: () {
        if (serverId != null) {
          // Optimistic local delete before telling server
          _removeQuestion(localId);
          context
              .read<ManageQuizCubit>()
              .deleteQuestionFromServer(serverId, _questions);
        }
      },
    );
  }
}
