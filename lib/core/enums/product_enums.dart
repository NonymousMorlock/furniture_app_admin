enum DimensionsUnit {
  inches('in'),
  cm('cm'),
  m('m'),
  mm('mm');

  const DimensionsUnit(this.value);
  final String value;
}

enum Availability {
  inStore('inStore'),
  online('online'),
  inStoreAndOnline('any');

  const Availability(this.value);
  final String value;
}

enum WeightUnit {
  kg('kg'),
  g('g');

  const WeightUnit(this.value);
  final String value;
}
