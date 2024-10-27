class Pair<T, E> {
  Pair(this.first, this.second);

  final T first;
  final E second;

  @override
  String toString() => 'Pair[$first, $second]';
}
