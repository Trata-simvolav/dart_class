import 'dart:math';

class FamilyMember {
  int many = 100;
  int food = 50;
  int dirt = 0;

  List<int> eat(int hungry) {
    if (this.food >= hungry) {
      this.food -= hungry;
      return [this.food, hungry]; // возращает скок осталось, и сколько съел
    } else if (this.food != 0) {
      int afforableFood = hungry - this.food;
      this.food -= afforableFood;
      return [
        this.food,
        afforableFood
      ]; // возращает скок осталось, и сколько съел
    } else {
      return [0, 0]; // возращает скок осталось, и сколько съел
    }
  }

  void dirting(String who) {
    if (who == "human") {
      this.dirt += 5;
    } else {
      this.dirt += 10;
    }
  }

  int clean() {
    if (this.dirt >= 100) {
      this.dirt -= 100;
      return this.dirt;
    } else {
      this.dirt = 0;
      return this.dirt;
    }
  }

  int work() {
    this.many += 150;
    return this.many;
  }

  int buyF() {
    int forBuy = 50 - this.food;
    if (forBuy < this.many) {
      this.many -= forBuy;
      this.food += forBuy;
      return this.food;
    } else if (this.many > 0) {
      this.food += this.many;
      this.many = 0;
      return this.food;
    } else {
      return 0;
    }
  }

  int buyS() {
    if (this.many >= 350) {
      this.many -= 350;
      return 60;
    } else {
      return 0;
    }
  }
}

// ---------------------------------------------------------------------------------------------------------
class Husband extends FamilyMember {
  String name = "Alex";
  int huppenes = 100;
  int hungry = 30;

  void eating() {
    super.dirting("human");

    List<int> result = super.eat(30 - this.hungry);

    if (result[0] == 0 && result[1] == 0) {
      print("В доме нет еды");
      return;
    }

    this.hungry += result[1];
    print(
        '$name съел ${result[1]} единиц еды. Осталось голода: ${this.hungry}.');
  }

  void playing() {
    this.hungry -= 10;
    super.dirting("human");

    this.huppenes += 20;
    print("$name поиграл в WoT. Его уровень счастья $huppenes");
  }

  void working() {
    this.hungry -= 10;
    super.dirting("human");

    int result = super.work();
    print("$name работал. Теперь в доме $result денег");
  }
}

// ---------------------------------------------------------------------------------------------------------
class Wife extends FamilyMember {
  String name = "Eliza";
  int huppenes = 100;
  int hungry = 30;

  void eating() {
    super.dirting("human");

    List<int> result = super.eat(30 - this.hungry);

    if (result[0] == 0 && result[1] == 0) {
      print("В доме нет еды");
      return;
    }

    this.hungry += result[1];
    print(
        '$name съела ${result[1]} единиц еды. Осталось голода: ${this.hungry}.');
  }

  void buyFood() {
    this.hungry -= 10;
    super.dirting("human");

    int result = super.buyF();
    if (result == 0) {
      print("У нас нет денег");
    } else if (result > 0) {
      print("У нас есть $result единиц еды");
    } else {
      print("Что то не так");
    }
  }

  void buyShuba() {
    this.hungry -= 10;
    super.dirting("human");

    int result = super.buyS();
    if (result == 60) {
      this.huppenes += 60;
      print(
          "$name купила шубу. Она счастлива! У неё ${this.huppenes} единиц счастья");
    } else {
      print("Жена не купила шубу. У неё ${this.huppenes} единиц счастья");
    }
  }

  void cleaning() {
    this.hungry -= 10;

    int result = super.clean();
    print("$name вытерла пыль с мужа. В доме $result единиц грязи");
  }
}

// ---------------------------------------------------------------------------------------------------------
class Actions {
  String lastnameFamily;

  FamilyMember familyMember;
  Husband husband;
  Wife wife;
  Actions(this.lastnameFamily)
      : familyMember = FamilyMember(),
        husband = Husband(),
        wife = Wife();

  bool alive() {
    if (husband.hungry > 0 &&
        husband.huppenes > 0 &&
        wife.hungry > 0 &&
        wife.huppenes > 0) {
      return true;
    } else {
      return false;
    }
  }

  void followLiveForHusband({int condition = 0}) {
    if (husband.hungry <= 10 || condition == 1) {
      husband.eating();
      // print("${husband.name} поел");
    } else if (husband.huppenes <= 10 || condition == 2) {
      husband.playing();
      // print("${husband.name} поиграл в WoT");
    } else if (familyMember.many <= 20 || condition == 3) {
      husband.working();
      // print("${husband.name} поработал");
    } else {
      int randomNumber = Random().nextInt(3) + 1;
      this.followLiveForHusband(condition: randomNumber);
    }
  }

  void followLiveForWife({int condition = 0}) {
    if (wife.hungry <= 10 || condition == 1) {
      wife.eating();
      // print("${wife.name} поела");
    } else if (wife.huppenes <= 10 || condition == 2) {
      wife.buyShuba();
      // print("${wife.name} купила шубу");
    } else if (familyMember.food <= 10 || condition == 3) {
      wife.buyFood();
      // print("${wife.name} купила еды в дом");
    } else if (familyMember.dirt >= 80 || condition == 4) {
      wife.cleaning();
      // print("${wife.name} убралась");
    } else {
      int randomNumber = Random().nextInt(4) + 1;
      this.followLiveForWife(condition: randomNumber);
    }
  }
}

void main() {
  Actions actionPanel = Actions("Воронины");

  for (int i = 1; i < 356; i++) {
    print("-----------------------------------------");
    print('День $i');

    actionPanel.followLiveForHusband();
    actionPanel.followLiveForWife();
    if (!actionPanel.alive()) {
      print(
          "Кто-то в семьи ${actionPanel.lastnameFamily} умер. Игра не пройдена! Попробуй ещё раз!");
      return;
    }
  }
}
