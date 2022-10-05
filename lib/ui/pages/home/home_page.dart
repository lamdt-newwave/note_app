import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/common/app_images.dart';

import '../../../common/app_colors.dart';
import 'home_cubit.dart';
import 'widgets/note_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
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
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: AppColors.lightSecondary,
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Search your note’s title here ...",
                      hintStyle: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.lightPlaceHolder),
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        size: 24,
                        color: AppColors.darkPrimary,
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
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.notes.length,
                          itemBuilder: (_, index) {
                            final note = state.notes[index];
                            return NoteListItem(
                              noteEntity: note,
                              onPressed: () {},
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildActionButton() {
    return Container(
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
    );
  }
}
