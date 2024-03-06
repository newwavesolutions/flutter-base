import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/enums/gender_type.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_navigator.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/picker/app_dropdown_picker.dart';
import 'package:flutter_base/ui/widgets/text/app_lable.dart';
import 'package:flutter_base/ui/widgets/text_field/app_date_input.dart';
import 'package:flutter_base/ui/widgets/text_field/app_text_field.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'update_profile_cubit.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateProfileCubit(
          navigator: UpdateProfileNavigator(context: context),
        );
      },
      child: const UpdateProfileChildPage(),
    );
  }
}

class UpdateProfileChildPage extends StatefulWidget {
  const UpdateProfileChildPage({super.key});

  @override
  State<UpdateProfileChildPage> createState() => _UpdateProfileChildPageState();
}

class _UpdateProfileChildPageState extends State<UpdateProfileChildPage>
    with TickerProviderStateMixin {
  late final UpdateProfileCubit _cubit;
  late TextEditingController textNameController;
  late TextEditingController textBirthdayController;
  late AppDropdownController genderController = AppDropdownController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    final user = context.read<UserCubit>().state.user;
    textNameController = TextEditingController(text: user?.username ?? '');
    textBirthdayController = TextEditingController(
      text: AppDateUtils.toDateString(user?.birthday),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Update Profile",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingNormal),
          child: AppButton(
            title: S.of(context).button_save,
            onPressed: saveProfile,
          ),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingNormal),
      child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppLabel(
                text: "Name",
                margin: EdgeInsets.only(bottom: AppDimens.paddingSmall),
              ),
              AppTextField(controller: textNameController),
              const AppLabel(
                text: "Birthday",
                margin: EdgeInsets.only(
                  top: AppDimens.paddingNormal,
                  bottom: AppDimens.paddingSmall,
                ),
              ),
              AppDateInput(
                controller: textBirthdayController,
                suffixIcon: const Icon(Icons.edit_calendar),
              ),
              const AppLabel(
                text: "Gender",
                margin: EdgeInsets.only(
                  top: AppDimens.paddingNormal,
                  bottom: AppDimens.paddingSmall,
                ),
              ),
              AppDropdownPicker(
                controller: genderController,
                options: GenderType.values.map((e) => e.text).toList(),
              )
            ],
          );
        },
      ),
    );
  }

  void saveProfile() {
    if (genderController.position == -1) {
      // Handle unselect gender
      return;
    }
    final gender = GenderType.values[genderController.position];
    _cubit.updateData(
      name: textNameController.text,
      birthday: DateFormat('dd/MM/yyyy').parse(textBirthdayController.text),
      gender: gender,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
