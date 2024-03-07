part of 'term_policy_cubit.dart';

class TermPolicyState extends Equatable {
  final LoadStatus termPolicyStatus;

  const TermPolicyState({
    this.termPolicyStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        termPolicyStatus,
      ];

  TermPolicyState copyWith({
    LoadStatus? termPolicyStatus,
  }) {
    return TermPolicyState(
      termPolicyStatus: termPolicyStatus ?? this.termPolicyStatus,
    );
  }
}
