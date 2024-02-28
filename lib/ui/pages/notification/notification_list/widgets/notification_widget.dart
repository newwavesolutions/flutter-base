import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/notification/notification_entity.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onPressed;

  const NotificationWidget({
    super.key,
    required this.notification,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppShadow.defaultShadow,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: InkWell(
          onTap: onPressed,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("공지사항", style: AppTextStyle.blackS14Bold),
                    ),
                    Text("2024-01-01", style: AppTextStyle.grayS12)
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Text(
                        "KR01",
                        style: AppTextStyle.whiteS12Bold.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '송도 A기업 문제상황 발생 시 매니저에게 연락해 주세요.',
                        textAlign: TextAlign.start,
                        style:
                            AppTextStyle.blackS14Medium.copyWith(fontSize: 13),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
