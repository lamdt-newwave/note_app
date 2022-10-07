import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:note_app/common/app_images.dart';
import 'package:note_app/models/enums/load_status.dart';
import 'package:note_app/router/app_routes.dart';

import '../../../common/app_colors.dart';
import '../../../models/entities/note.dart';
import '../../widgets/button/circular_action_button.dart';
import '../../widgets/shimmer/app_shimmer.dart';
import '../../widgets/textfields/search_widget.dart';
import 'home_cubit.dart';
import 'widgets/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchNotes();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 54,
                child: Text(
                  "My Notes",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              _buildSearch(context),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 36,
                child: Text(
                  "Note List",
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              _buildNoteList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loadNoteStatus == LoadStatus.loading) {
          return Container();
        } else {
          return AnimatedCrossFade(
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
            firstCurve: Curves.linear,
            secondCurve: Curves.linear,
            sizeCurve: Curves.bounceInOut,
            firstChild: CircularActionButton(
              backgroundColor: AppColors.redAccent,
              onPressed: _cubit.onDisableDeleteNote,
              icon: AppImages.icCheck,
              iconColor: AppColors.lightPrimary,
            ),
            secondChild: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: state.notes.isNotEmpty,
                  child: CircularActionButton(
                    backgroundColor: AppColors.redAccent,
                    onPressed: _cubit.onEnableDeleteNote,
                    icon: AppImages.icTrash,
                    iconColor: AppColors.lightPrimary,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                CircularActionButton(
                  backgroundColor: AppColors.greenAccent,
                  onPressed: _cubit.onCreateNewNote,
                  icon: AppImages.icAdd,
                  iconColor: AppColors.lightPrimary,
                ),
              ],
            ),
            crossFadeState: state.isEnableDelete && state.notes.isNotEmpty
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(seconds: 1),
          );
        }
      },
    );
  }

  Widget _buildSearch(BuildContext context) {
    return SearchWidget(
      controller: _controller,
      fillColor: AppColors.lightSecondary,
      onChanged: _cubit.onTextFieldChanged,
      hintText: "Search your note’s title here ...",
      hintStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.lightPlaceHolder),
      suffixIcon: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return _controller.text.isEmpty
              ? const Icon(
                  Icons.search_outlined,
                  size: 24,
                  color: AppColors.darkPrimary,
                )
              : InkWell(
                  onTap: () {
                    _cubit.onClearTextField();
                    _controller.clear();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.darkPrimary,
                  ),
                );
        },
      ),
    );
  }

  Widget _buildNoteList(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.loadNoteStatus == LoadStatus.success) {
          return _buildSuccessfulList(
              state.notes, state.isEnableDelete, context);
        } else if (state.loadNoteStatus == LoadStatus.loading) {
          return _buildLoadingList();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const AppShimmer(
                height: 165,
                width: double.infinity,
                cornerRadius: 10,
              ),
            );
          }),
    );
  }

  Widget _buildSuccessfulList(
      List<NoteEntity> notes, bool isEnableDelete, BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.notes.isEmpty) {
          return SizedBox(
            height: 27,
            child: Text(
              "Add your first note please :D",
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: AppColors.redAccent),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (_, index) {
                final note = notes[index];
                return NoteCard(
                  onPressed: () {
                    Get.toNamed(AppRoutes.detailNote, arguments: note.id);
                  },
                  isSelectedNote: state.selectedIndex == index,
                  noteEntity: note,
                  onDelete: () => _cubit.onDeleteNote(index),
                  isEnableDelete: isEnableDelete,
                  onConfirm: () => _cubit.onConfirmDeleteNote(index),
                  onCancel: () => _cubit.onCancelDeleteNote(),
                );
              }),
        );
      },
    );
  }
}
