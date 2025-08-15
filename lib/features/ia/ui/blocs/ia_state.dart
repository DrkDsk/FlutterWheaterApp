enum IAClientStatus { initial, loading, success, error }

class IaState {
  final String recommendation;
  final IAClientStatus status;
  final String? errorMessage;

  const IaState({
    this.recommendation = "",
    this.status = IAClientStatus.initial,
    this.errorMessage,
  });

  IaState copyWith({
    String? recommendation,
    IAClientStatus? status,
    String? errorMessage,
  }) {
    return IaState(
      recommendation: recommendation ?? this.recommendation,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
