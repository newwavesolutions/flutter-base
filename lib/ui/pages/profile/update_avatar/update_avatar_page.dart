import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_navigator.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/divider/app_divider.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';
import 'package:flutter_base/ui/widgets/loading/app_loading_indicator.dart';
import 'package:flutter_base/ui/widgets/picker/app_image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_avatar_cubit.dart';

class UpdateAvatarPage extends StatelessWidget {
  const UpdateAvatarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final userCubit = RepositoryProvider.of<UserCubit>(context);
        return UpdateAvatarCubit(
          navigator: UpdateAvatarNavigator(context: context),
          userRepository: userRepo,
          userCubit: userCubit,
        );
      },
      child: const UpdateAvatarChildPage(),
    );
  }
}

class UpdateAvatarChildPage extends StatefulWidget {
  const UpdateAvatarChildPage({super.key});

  @override
  State<UpdateAvatarChildPage> createState() => _UpdateAvatarChildPageState();
}

class _UpdateAvatarChildPageState extends State<UpdateAvatarChildPage> {
  late final UpdateAvatarCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Avatar",
        actions: [
          BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
            builder: (context, state) {
              return _cubit.state.image == null
                  ? TextButton(
                      onPressed: () async {
                        if (_cubit.state.updateImageStatus ==
                            LoadStatus.loading) return;
                        showOption();
                      },
                      child: const Text("Upload"),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (_cubit.state.updateImageStatus ==
                            LoadStatus.loading) return;
                        showOption();
                      },
                      child: const Text("Update"),
                    );
            },
          )
        ],
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
        builder: (context, state) {
          return state.updateImageStatus == LoadStatus.loading
              ? const AppCircularProgressIndicator()
              : state.image == null
                  ? const AppCircleAvatar(size: Size(400, 400))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.file(
                        state.image ?? File(''),
                        width: 400,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    );
        },
      ),
    );
  }

  Future<void> showOption() async {
    await _cubit.navigator.showBottomSheet(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Edit Image",
            ),
            const AppDivider(
              height: 16,
              thickness: 1,
            ),
            ListTile(
              onTap: () async {
                await onChooseImageFromGallery();
              },
              leading: const Icon(
                Icons.collections,
                size: 24,
                color: Colors.red,
              ),
              title: const Text(
                "Choose from the collection",
              ),
            ),
            ListTile(
              onTap: () async {
                await onChooseImageFromCamera();
              },
              leading: const Icon(
                Icons.photo_camera,
                size: 24,
                color: Colors.green,
              ),
              title: const Text(
                "Take a photo",
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> onChooseImageFromGallery() async {
    final result = await AppImagePicker.getImageFromGallery(context);
    _cubit.navigator.pop();
    if (result != null) {
      final file = File(result.path);
      await _cubit.updateImage(file);
    }
  }

  Future<void> onChooseImageFromCamera() async {
    final result = await AppImagePicker.getImageFromCamera(context);
    _cubit.navigator.pop();
    if (result != null) {
      final file = File(result.path);
      await _cubit.updateImage(file);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
