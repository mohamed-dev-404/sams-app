import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmitMixin<S> on BlocBase<S> {
  @override
  void emit(S state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}