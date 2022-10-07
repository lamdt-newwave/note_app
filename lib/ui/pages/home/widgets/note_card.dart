import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app/models/entities/note.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class NoteCard extends StatefulWidget {
  final NoteEntity noteEntity;
  final GestureTapCallback onDelete;
  final GestureTapCallback onConfirm;
  final GestureTapCallback onCancel;
  final GestureTapCallback onPressed;
  final bool isEnableDelete;
  final bool isSelectedNote;

  const NoteCard({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
    required this.isEnableDelete,
    required this.noteEntity,
    required this.onDelete,
    required this.isSelectedNote,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: widget.isEnableDelete ? 211 : 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightSecondary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 23,
                    ),
                    Text(
                      widget.noteEntity.title,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 84,
                      child: Text(
                        widget.noteEntity.text,
                        style: theme.textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            widget.isEnableDelete
                ? AnimatedCrossFade(
                    firstChild: _buildChoiceOptions(),
                    secondChild: _buildDeleteButton(),
                    crossFadeState: widget.isSelectedNote
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500))
                : Container(),
          ],
        ),
      ),
    );
  }

  Container _buildChoiceOptions() {
    return Container(
      height: 46,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8),),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: widget.onCancel,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(8),),
                    color: AppColors.greenAccent),
                child: Center(
                  child: SvgPicture.asset(AppImages.icClose,),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: widget.onConfirm,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8),),
                    color: AppColors.redAccent),
                child: Center(
                  child: SvgPicture.asset(AppImages.icCheck),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell _buildDeleteButton() {
    return InkWell(
      onTap: widget.onDelete,
      child: Container(
        height: 46,
        decoration: const BoxDecoration(
          color: AppColors.redAccent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        ),
        child: Center(
          child: SvgPicture.asset(
            AppImages.icTrash,
            width: 24,
            height: 24,
            color: AppColors.lightPrimary,
          ),
        ),
      ),
    );
  }
}
