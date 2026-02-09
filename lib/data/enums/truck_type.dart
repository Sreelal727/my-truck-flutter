enum TruckType {
  tataAce('Tata Ace / Mini', '750 kg'),
  bolero('Bolero Pickup', '1.5 ton'),
  tata407('Tata 407', '2.5 ton'),
  eicher14ft('Eicher 14ft', '4 ton'),
  eicher17ft('Eicher 17ft', '7 ton'),
  taurus16t('Taurus 16T', '9 ton'),
  container20ft('Container 20ft', '7 ton'),
  container32ft('Container 32ft', '15 ton'),
  trailer40ft('Trailer 40ft', '21 ton'),
  openBody('Open Body', 'Varies'),
  closedBody('Closed Body', 'Varies'),
  flatbed('Flatbed', 'Varies'),
  tanker('Tanker', 'Varies'),
  refrigerated('Refrigerated', 'Varies');

  const TruckType(this.label, this.capacity);
  final String label;
  final String capacity;
}
