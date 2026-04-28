import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/widgets/shared/general_arrow_back.dart';
import 'package:sams_app/features/assignments/data/model/get_all_submissions/student_info_model.dart';

class SubmissionDetailsHeader extends StatelessWidget {
  const SubmissionDetailsHeader({super.key, required this.studentInfo});
  final StudentInfoModel studentInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Column(
        children: [
          /// Top Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizeConfig.isMobile(context)
                    ? IconButton(
                        onPressed: () => context.pop(),
                        icon: const GeneralArrowBack(
                          color: AppColors.white,
                        ),
                      )
                    : const SizedBox(width: 40),
                SizeConfig.isMobile(context)
                    ? const SizedBox(width: 40)
                    : const Expanded(child: SizedBox()),
                const Text(
                  'Student Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizeConfig.isMobile(context)
                    ? const SizedBox(width: 40)
                    : const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Avatar
           CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child:studentInfo.profilePic==null?  Text(
              studentInfo.name?.substring(0,2).toUpperCase()??'',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ): Image.network(
              studentInfo.profilePic!,  
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),

          /// Name
           Text(
            studentInfo.name??'',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          /// ID
           Text(
            'ID: ${studentInfo.academicId}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
