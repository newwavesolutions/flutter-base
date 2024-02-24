import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_navigator.dart';
import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:flutter_base/ui/widgets/picker/app_date_picker.dart';
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
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return UpdateProfileCubit(
          appCubit: appCubit,
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
  late TextEditingController textPhoneNumberController;
  late TextEditingController textBirthdayController;
  late TextEditingController textAddressController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.getUser();
    textNameController =
        TextEditingController(text: _cubit.state.user?.username ?? '');
    textPhoneNumberController =
        TextEditingController(text: _cubit.state.user?.phone ?? "");
    textBirthdayController = TextEditingController(
        text: DateTimeExtension(_cubit.state.user?.birthday ?? DateTime.now())
            .toDateString()
            .toString());
    textAddressController =
        TextEditingController(text: _cubit.state.user?.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update profile"),
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              AppTextField(
                labelText: "Name",
                controller: textNameController,
              ),
              const SizedBox(
                height: 16,
              ),
              AppTextField(
                labelText: "Phone number",
                controller: textPhoneNumberController,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                buildWhen: (previous, current) =>
                    previous.birthdayStatus != current.birthdayStatus,
                builder: (context, state) {
                  return InkWell(
                    onTap: _openDatePicker,
                    child: AppTextField(
                      controller: textBirthdayController,
                      labelText: 'Birthday',
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              AppTextField(
                labelText: "Address",
                controller: textAddressController,
              ),
              const Spacer(),
              AppButton(
                title: "update",
                cornerRadius: 20,
                textStyle: AppTextStyle.blackS16,
                onPressed: updateProfile,
              ),
            ],
          );
        },
      ),
    );
  }

  void _openDatePicker() async {
    final dateTime = await AppDatePicker.pickDate(context);
    textBirthdayController.text =
        DateTimeExtension(dateTime ?? DateTime.now()).toDateString().toString();
  }

  void updateProfile() {
    _cubit.updateData(
      name: textNameController.text,
      phone: textPhoneNumberController.text,
      birthday: DateFormat('dd/MM/yyyy').parse(textBirthdayController.text),
      address: textAddressController.text,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
