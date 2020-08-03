
class SaleInformation {

  String id;
  String name;
  String description;
  String amount;
  int number;

  sumNumber() {
    number += 1;
  }

  minNumber() {
    number -= 1;
  }

  SaleInformation({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.number
  });
}