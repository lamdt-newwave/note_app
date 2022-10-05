import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/common/app_images.dart';
import 'package:note_app/models/enums/load_status.dart';

import '../../../common/app_colors.dart';
import '../../../models/entities/note.dart';
import '../../widgets/shimmer/app_shimmer.dart';
import 'home_cubit.dart';
import 'widgets/note_list_item.dart';

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
      floatingActionButton: _buildActionButton(),
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
              SizedBox(
                height: 52,
                child: TextFormField(
                  controller: _controller,
                  maxLines: 1,
                  onChanged: (value) => _cubit.onTextFieldChanged(value),
                  decoration: InputDecoration(
                    fillColor: AppColors.lightSecondary,
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Search your note’s title here ...",
                    hintStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.lightPlaceHolder),
                    suffixIcon: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return _controller.text.isEmpty
                            ? const Icon(
                                Icons.search_outlined,
                                size: 24,
                                color: AppColors.darkPrimary,
                              )
                            : InkWell(
                                onTap: ()  {
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
                  ),
                ),
              ),
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
              _buildNoteList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteList() {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        print("12321313");
        if (state.loadNoteStatus == LoadStatus.success) {
          return _buildSuccessfulList(state.notes, state.isEnableDelete);
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
          itemCount: 20,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const AppShimmer(
                height: 100,
                width: double.infinity,
                cornerRadius: 10,
              ),
            );
          }),
    );
  }

  Widget _buildSuccessfulList(List<NoteEntity> notes, bool isEnableDelete) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (_, index) {
                final note = notes[index];
                return NoteListItem(
                  isSelectedNote: state.selectedIndex == index,
                  noteEntity: note,
                  onPressed: () => _cubit.onSelectDeleteNote(index),
                  isEnableDelete: isEnableDelete,
                  onDelete: () => _cubit.onDeleteNote(index),
                  onCancel: () => _cubit.onCancelDeleteNote(),
                );
              }),
        );
      },
    );
  }

  Widget _buildActionButton() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.isEnableDelete
            ? InkWell(
                onTap: () => _cubit.onEnableDeleteNote(),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.redAccent),
                  child: Center(
                      child: SvgPicture.asset(
                    AppImages.icCheck,
                    height: 24,
                    width: 24,
                    color: AppColors.lightPrimary,
                  )),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => _cubit.onEnableDeleteNote(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.redAccent),
                      child: Center(
                          child: SvgPicture.asset(
                        AppImages.icTrash,
                        height: 24,
                        width: 24,
                        color: AppColors.lightPrimary,
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.greenAccent),
                    child: Center(
                        child: SvgPicture.asset(
                      AppImages.icAdd,
                      height: 24,
                      width: 24,
                      color: AppColors.lightPrimary,
                    )),
                  ),
                ],
              );
      },
    );
  }
}
