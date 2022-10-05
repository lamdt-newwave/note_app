import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app/models/entities/note.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class NoteListItem extends StatelessWidget {
  final NoteEntity noteEntity;
  final GestureTapCallback onPressed;
  const NoteListItem({
    Key? key,
    required this.noteEntity,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 211,
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
                  noteEntity.title,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 84,
                  child: Text(
                    noteEntity.text,
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
          Container(
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
          )
        ],
      ),
    );
  }
}
