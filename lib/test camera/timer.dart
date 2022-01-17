class CountDownTimer {
  const CountDownTimer();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x + 1);
  }
}
