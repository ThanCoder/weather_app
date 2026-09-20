sealed class Result<T, E> {
  const Result();

  bool get isOk => this is Ok<T, E>;
  bool get isErr => this is Err<T, E>;

  T unwrap() {
    return switch (this) {
      Ok(value: final val) => val,
      Err() => throw StateError('Called `unwrap()` on Err'),
    };
  }

  E unwrapError() {
    return switch (this) {
      Err(value: final val) => val,
      Ok() => throw StateError('Called `unwrapError()` on Ok'),
    };
  }
}

class Ok<T, E> extends Result<T, E> {
  final T value;
  const Ok(this.value);
}

class Err<T, E> extends Result<T, E> {
  final E value;
  const Err(this.value);
}
