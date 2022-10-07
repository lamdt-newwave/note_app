import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:note_app/ui/pages/new_note/new_note_cubit.dart';
import 'package:note_app/utils/app_date_utils.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';
import '../../widgets/button/circular_action_button.dart';
import '../home/home_cubit.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({Key? key}) : super(key: key);

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  late final TextEditingController _textController;
  late final TextEditingController _titleController;
  late final FocusNode textFocusNote;
  late NewNoteCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<NewNoteCubit>();
    _textController = TextEditingController();
    _titleController = TextEditingController();
    textFocusNote = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: _cubit.onTitleChanged,
                maxLines: 1,
                controller: _titleController,
                keyboardType: TextInputType.multiline,
                style: theme.textTheme.headlineMedium,
                decoration: InputDecoration(
                    hintText: "Write title here ...",
                    hintStyle: theme.textTheme.headlineMedium
                        ?.copyWith(color: AppColors.greenAccent),
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppColors.lightPrimary),
              ),
              BlocBuilder<NewNoteCubit, NewNoteState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 18,
                    child: Text(
                      AppDateUtils.toDateTimeString(state.newNote.createdTime),
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                },
              ),
              Expanded(
                child: TextFormField(
                  onChanged: _cubit.onTextChanged,
                  focusNode: textFocusNote,
                  maxLines: null,
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                      hintStyle: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.greenAccent),
                      hintText: "Write content here ...",
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.lightPrimary),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<NewNoteCubit, NewNoteState>(
      bloc: _cubit,
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
              onPressed: () {
                context.read<HomeCubit>().fetchNotes();
                _cubit.onBack();
              },
            ),
            const Spacer(),
            CircularActionButton(
                backgroundColor: _cubit.hasContent()
                    ? AppColors.greenAccent
                    : AppColors.greenAccent.withOpacity(0.5),
                icon: AppImages.icSave,
                onPressed: () {
                  _cubit.onCreateNewNote();
                  context.read<HomeCubit>().fetchNotes();
                  Get.back();
                },
                iconColor: AppColors.lightPrimary)
          ],
        );
      },
    );
  }
}
