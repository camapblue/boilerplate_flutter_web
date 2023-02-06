part of 'breadcrumb_bloc.dart';

abstract class BreadcrumbEvent {
  const BreadcrumbEvent();
}

class BreadcrumbNavigatedTo extends BreadcrumbEvent {
  final int index;

  const BreadcrumbNavigatedTo(this.index);
}

class BreadcrumbSet extends BreadcrumbEvent {
  final List<BreadcrumbPage> pages;

  const BreadcrumbSet(this.pages);
}