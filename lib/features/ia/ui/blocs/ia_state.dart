enum IAClientStatus { initial, loading, success, error }

class IAState {
  final String recommendation;
  final IAClientStatus status;
  final String? errorMessage;

  const IAState({
    this.recommendation = "",
    this.status = IAClientStatus.initial,
    this.errorMessage,
  });

  IAState copyWith({
    String? recommendation,
    IAClientStatus? status,
    String? errorMessage,
  }) {
    return IAState(
      recommendation: recommendation ?? this.recommendation,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
