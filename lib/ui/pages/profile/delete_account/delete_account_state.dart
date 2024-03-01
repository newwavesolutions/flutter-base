part of 'delete_account_cubit.dart';

class DeleteAccountState extends Equatable {
  final LoadStatus deleteAccountStatus;

  const DeleteAccountState({
    this.deleteAccountStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        deleteAccountStatus,
      ];

  DeleteAccountState copyWith({
    LoadStatus? deleteAccountStatus,
  }) {
    return DeleteAccountState(
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
    );
  }
}
