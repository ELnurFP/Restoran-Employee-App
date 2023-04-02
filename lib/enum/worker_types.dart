// ignore_for_file: constant_identifier_names

enum WorkerTypes {
  Employee(0),
  Worker(1);

  const WorkerTypes(this.value);
  final int value;
}
