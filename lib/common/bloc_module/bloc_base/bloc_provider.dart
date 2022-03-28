import 'package:flutter/material.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.blocBuilder,
    required this.child,
    this.blocDispose,
  }) : super(key: key);

  final Widget? child;
  final BlocBuilder<T>? blocBuilder;
  final BlocDisposer<T>? blocDispose;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProviderInherited<T> provider = context
        .getElementForInheritedWidgetOfExactType<BlocProviderInherited<T>>()!
        .widget as BlocProviderInherited<T>;

    return provider.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder!();
  }

  @override
  void dispose() {
    if (widget.blocDispose != null) {
      widget.blocDispose!(bloc);
    } else {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child!,
    );
  }
}

class BlocProviderInherited<T> extends InheritedWidget {
  const BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(BlocProviderInherited oldWidget) => false;
}
