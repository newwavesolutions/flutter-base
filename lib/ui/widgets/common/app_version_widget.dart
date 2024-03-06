import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/pages/profile/profile_cubit.dart';
import 'package:flutter_base/ui/pages/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.version != current.version,
      builder: (context, state) {
        return Text(
          'Version: ${state.version}',
          style: AppTextStyle.blackS14,
        );
      },
    );
  }
}
