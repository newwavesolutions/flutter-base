import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notification;
  final Function()? onPressed;

  const NotificationWidget({
    Key? key,
    required this.notification,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : AppColors.primary.withOpacity(0.4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppCacheImage(
              url: notification.imageUrl ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? '',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.blackS16W800,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    notification.message ?? '',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.blackS16,
                    maxLines: 1,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: 63,
              child: Text(
                convertCreatedAt2String(
                  createdAt: notification.createdAt ?? DateTime.now(),
                ),
                style: notification.isRead == true
                    ? AppTextStyle.blackS12
                    : AppTextStyle.blackS12W800,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertCreatedAt2String({required DateTime createdAt}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(createdAt.year, createdAt.month, createdAt.day);
    if (aDate == today) {
      return DateFormat('HH:mm').format(createdAt);
    } else if (aDate == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('dd-MM').format(createdAt);
    }
  }
}
