import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app/models/entities/note.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class NoteListItem extends StatefulWidget {
  final NoteEntity noteEntity;
  final GestureTapCallback onPressed;
  final GestureTapCallback onDelete;
  final GestureTapCallback onCancel;
  final bool isEnableDelete;
  final bool isSelectedNote;

  const NoteListItem({
    Key? key,
    required this.onCancel,
    required this.onDelete,
    required this.isEnableDelete,
    required this.noteEntity,
    required this.onPressed,
    required this.isSelectedNote,
  }) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: widget.isEnableDelete ? 211 : 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightSecondary,
      ),
      child: Column(
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
          )),
          widget.isEnableDelete
              ? (widget.isSelectedNote
                  ? Container(
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: widget.onCancel,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8)),
                                    color: AppColors.greenAccent),
                                child: Center(
                                  child: SvgPicture.asset(AppImages.icClose),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: widget.onDelete,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8)),
                                    color: AppColors.redAccent),
                                child: Center(
                                  child: SvgPicture.asset(AppImages.icCheck),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: widget.onPressed,
                      child: Container(
                        height: 46,
                        decoration: const BoxDecoration(
                          color: AppColors.redAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
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
                    ))
              : const SizedBox()
        ],
      ),
    );
  }
}
