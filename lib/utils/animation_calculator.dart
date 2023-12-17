class AnimationCalculator {
  static double linearInterpolateToZeroOne(
      {required double scrollPercentage,
      required double start,
      required double end}) {
    if (scrollPercentage < start) {
      return 0;
    } else if (scrollPercentage > end) {
      return 1;
    } else {
      return (1 / (end - start)) * scrollPercentage - (start / (end - start));
    }
  }

  static double linearInterpolateToMinusOneOne(
      {required double scrollPercentage,
      required double start,
      required double end}) {
    if (scrollPercentage < start) {
      return -1;
    } else if (scrollPercentage > end) {
      return 1;
    } else {
      final mid = (end - start) / 2 + start;
      if (scrollPercentage < mid) {
        return (1 / (mid - start)) * scrollPercentage -
            (start / (mid - start)) -
            1;
      } else {
        return (1 / (end - mid)) * scrollPercentage - (mid / (end - mid));
      }
    }
  }
}
