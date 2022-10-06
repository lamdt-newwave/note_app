import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/common/app_colors.dart';
import 'package:note_app/common/app_images.dart';
import 'package:note_app/models/entities/note.dart';
import 'package:note_app/models/enums/load_status.dart';
import 'package:note_app/ui/pages/detail_note/detail_note_cubit.dart';
import 'package:note_app/ui/widgets/button/circular_action_button.dart';
import 'package:note_app/ui/widgets/common/404_page.dart';
import 'package:note_app/ui/widgets/common/loading_widget.dart';
import 'package:note_app/utils/app_date_utils.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({Key? key}) : super(key: key);

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late final TextEditingController _textController;
  late final TextEditingController _titleController;
  late final FocusNode textFocusNote;
  late DetailNoteCubit _cubit;

  @override
  void initState() {
    super.initState();
    int noteId = Get.arguments;
    _cubit = context.read<DetailNoteCubit>();
    _cubit.fetchNote(noteId);
    _textController = TextEditingController();
    _titleController = TextEditingController();
    textFocusNote = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailNoteCubit, DetailNoteState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.loadNoteStatus == LoadStatus.loading) {
          return _buildLoading(context);
        } else if (state.loadNoteStatus == LoadStatus.success) {
          return _buildPage(context, state.note!);
        } else {
          return const NotFoundPage();
        }
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const LoadingWidget();
  }

  Widget _buildPage(BuildContext context, NoteEntity note) {
    return Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: _buildContent(note, context));
  }

  Widget _buildContent(NoteEntity note, BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DetailNoteCubit, DetailNoteState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              AnimatedCrossFade(
                firstChild: SizedBox(
                    height: 36,
                    child: TextFormField(
                      maxLines: null,
                      controller: _titleController,
                      keyboardType: TextInputType.multiline,
                      style: theme.textTheme.headlineMedium,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppColors.lightPrimary),
                    )),
                secondChild: SizedBox(
                    height: 36,
                    child: Text(
                      note.title,
                      style: theme.textTheme.headlineMedium,
                    )),
                crossFadeState: state.isEditing
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                sizeCurve: Curves.linear,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 18,
                child: Text(
                  AppDateUtils.toDateTimeString(note.createdTime),
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              AnimatedCrossFade(
                firstChild: TextFormField(
                  focusNode: textFocusNote,
                  maxLines: null,
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  style: theme.textTheme.bodyMedium,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.lightPrimary),
                ),
                secondChild: Text(
                  note.text,
                  style: theme.textTheme.bodyMedium,
                ),
                crossFadeState: state.isEditing
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                sizeCurve: Curves.linear,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<DetailNoteCubit, DetailNoteState>(
      builder: (context, state) {
        return Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            CircularActionButton(
              backgroundColor: AppColors.darkPrimary,
              iconColor: AppColors.lightPrimary,
              icon: AppImages.icBack,
              onPressed: _cubit.onBack,
            ),
            const Spacer(),
            state.isEditing || state.isDeleting
                ? AnimatedCrossFade(
                    layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            child: bottomChild,
                          ),
                          Positioned(
                            child: topChild,
                          ),
                        ],
                      );
                    },
                    duration: const Duration(milliseconds: 500),
                    firstCurve: Curves.linear,
                    secondCurve: Curves.linear,
                    sizeCurve: Curves.bounceInOut,
                    firstChild: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircularActionButton(
                            backgroundColor: AppColors.greenAccent,
                            icon: AppImages.icClose,
                            onPressed: _cubit.onCancel,
                            iconColor: AppColors.lightPrimary),
                        const SizedBox(
                          width: 24,
                        ),
                        CircularActionButton(
                            backgroundColor: AppColors.redAccent,
                            icon: AppImages.icCheck,
                            onPressed: () {
                              _cubit.onConfirm(state.note!.copyWith(
                                  title: _titleController.text,
                                  text: _textController.text), context);
                            },
                            iconColor: AppColors.lightPrimary)
                      ],
                    ),
                    secondChild: CircularActionButton(
                      backgroundColor: AppColors.greenAccent,
                      onPressed: _cubit.onSaveNote,
                      icon: AppImages.icSave,
                      iconColor: AppColors.lightPrimary,
                    ),
                    crossFadeState: state.isSaving || state.isDeleting
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  )
                : Row(
                    children: [
                      CircularActionButton(
                        backgroundColor: AppColors.redAccent,
                        onPressed: _cubit.onDeleteNote,
                        icon: AppImages.icTrash,
                        iconColor: AppColors.lightPrimary,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      CircularActionButton(
                        backgroundColor: AppColors.greenAccent,
                        onPressed: () {
                          _cubit.onEnableEditing();
                          _textController.text = state.note?.text ?? "";
                          _titleController.text = state.note?.title ?? "";
                          textFocusNote.requestFocus();
                        },
                        icon: AppImages.icPen,
                        iconColor: AppColors.lightPrimary,
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
