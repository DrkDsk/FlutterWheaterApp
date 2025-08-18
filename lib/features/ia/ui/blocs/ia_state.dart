enum IAClientStatus { initial, loading, success, error }

class IAState {
  final List<String> recommendations;
  final IAClientStatus status;
  final String? errorMessage;

  const IAState({
    this.recommendations = const [],
    this.status = IAClientStatus.initial,
    this.errorMessage,
  });

  IAState copyWith({
    List<String>? recommendations,
    IAClientStatus? status,
    String? errorMessage,
  }) {
    return IAState(
      recommendations: recommendations ?? this.recommendations,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
