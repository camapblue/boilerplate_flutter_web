part of 'breadcrumb_bloc.dart';

abstract class BreadcrumbState extends Equatable {
  final List<BreadcrumbPage> pages;
  final DateTime showTime;

  BreadcrumbState({this.pages = const <BreadcrumbPage>[]})
      : showTime = DateTime.now();

  @override
  List<Object> get props => [showTime];
}

class BreadcrumbInitial extends BreadcrumbState {
  BreadcrumbInitial(List<BreadcrumbPage> pages): super(pages: pages);
}

class BreadcrumbNavigateSuccess extends BreadcrumbState {
  BreadcrumbNavigateSuccess(List<BreadcrumbPage> pages)
      : super(pages: pages);
}