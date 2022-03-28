import 'package:flutter/material.dart';
import 'package:rx_bloc/common/bloc_module/bloc_base/bloc_event_state.dart';

typedef AsyncBlocStateBuilder<BlocState> = Widget Function(
    BuildContext context, BlocState state);

class BlocEventStateBuilder<BlocState> extends StatelessWidget {
  const BlocEventStateBuilder({
    Key? key,
    required this.builder,
    required this.bloc,
  }) : super(key: key);

  final BlocEventStateBase<BlocEvent, BlocState> bloc;
  final AsyncBlocStateBuilder<BlocState> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
        return builder(context, snapshot.data!);
      },
    );
  }
}
