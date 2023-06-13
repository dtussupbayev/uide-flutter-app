import 'package:flutter/material.dart';

class ProjectNotifierProvider<Model extends ChangeNotifier>
    extends StatefulWidget {
  final Widget child;
  final bool isManagingModel;
  final Model Function() create;

  const ProjectNotifierProvider({
    Key? key,
    required this.child,
    this.isManagingModel = true,
    required this.create,
  }) : super(key: key);

  @override
  State<ProjectNotifierProvider<Model>> createState() =>
      _ProjectNotifierProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _ProjectNotifierProviderState<Model extends ChangeNotifier>
    extends State<ProjectNotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider(
      model: _model,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    super.dispose();
  }
}

class _InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const _InheritedNotifierProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );
}

class ProjectProvider<Model> extends InheritedWidget {
  final Model model;

  const ProjectProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static Model? watch<Model>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProjectProvider<Model>>()
        ?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProjectProvider<Model>>()
        ?.widget;
    return widget is ProjectProvider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(ProjectProvider oldWidget) {
    return model != oldWidget.model;
  }
}
