import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';

import 'breadcrumb_view.dart';

class Breadcrumb extends StatelessWidget {
  final void Function(int)? onPageSelected;

  const Breadcrumb({
    super.key,
    this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreadcrumbBloc, BreadcrumbState>(
      builder: (_, state) {
        return BreadcrumbView(
          data: state.pages,
          onPageSelected: onPageSelected != null
              ? (page, index) {
                  if (onPageSelected != null) {
                    onPageSelected!(index);
                  }
                }
              : null,
        );
      },
    );
  }
}
