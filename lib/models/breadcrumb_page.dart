import 'package:equatable/equatable.dart';

class BreadcrumbPage extends Equatable {
  final String title;
  final String linkTo;
  final Map<String, dynamic>? params;

  const BreadcrumbPage({
    required this.title,
    required this.linkTo,
    this.params,
  });

  BreadcrumbPage copyWith({
    String? title,
    Map<String, dynamic>? params
  }) {
    return BreadcrumbPage(
      title: title ?? this.title,
      linkTo: linkTo,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [title, linkTo];
}