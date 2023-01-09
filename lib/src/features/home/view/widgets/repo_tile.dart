import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../model/flutter_repo.dart';

class RepoTile extends StatelessWidget {
  const RepoTile({
    Key? key,
    required this.flutterRepo,
    required this.index,
  }) : super(key: key);
  final int index;
  final FlutterRepo flutterRepo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: index == 0 ? 20 : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index % 2 != 0
              ? AppColors.secondary.withOpacity(0.5)
              : AppColors.secondary),
      child: ListTile(
        title: Text(
          flutterRepo.repoName,
          style: textTheme.bodyText2,
        ),
        subtitle: Text(
          flutterRepo.repoOwner,
          style: textTheme.subtitle2,
        ),
      ),
    );
  }
}
