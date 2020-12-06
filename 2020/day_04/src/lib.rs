use std::collections::HashMap;
use regex::Regex;

pub struct PartOne;
pub struct PartTwo;

struct Document {
  pub byr: String,
  pub iyr: String,
  pub eyr: String,
  pub hgt: String,
  pub hcl: String,
  pub ecl: String,
  pub pid: String,
  pub cid: String
}

impl PartOne {
  pub fn solve(input: &str) -> i32 {
    let documents: Vec<Document> = input.split("\n\n").map(|doc| Document::new(doc)).collect();

    let mut valid_count = 0;

    for document in documents {
      if document.valid() {
        valid_count = valid_count + 1;
      }
    }

    valid_count
  }
}

#[test]
fn example_1() {
  let input = std::fs::read_to_string("resources/example_1.txt").expect("Something went wrong reading the file");
  assert_eq!(PartOne::solve(&input), 2);
}

impl PartTwo {
  pub fn solve(input: &str) -> i32 {
    let documents: Vec<Document> = input.split("\n\n").map(|doc| Document::new(doc)).collect();

    let mut valid_count = 0;

    for document in documents {
      if document.valid_2() {
        valid_count = valid_count + 1;
      }
    }

    valid_count
  }
}

#[test]
fn example_2() {
  let input = std::fs::read_to_string("resources/example_2.txt").expect("Something went wrong reading the file");
  assert_eq!(PartTwo::solve(&input), 4);
}

impl Document {
  pub fn new(input: &str) -> Document {
    let values = Document::get_values(input);

    Document {
      byr: values.get("byr").unwrap_or(&"").to_string(),
      iyr: values.get("iyr").unwrap_or(&"").to_string(),
      eyr: values.get("eyr").unwrap_or(&"").to_string(),
      hgt: values.get("hgt").unwrap_or(&"").to_string(),
      hcl: values.get("hcl").unwrap_or(&"").to_string(),
      ecl: values.get("ecl").unwrap_or(&"").to_string(),
      pid: values.get("pid").unwrap_or(&"").to_string(),
      cid: values.get("cid").unwrap_or(&"").to_string(),
    }
  }

  pub fn valid(&self) -> bool {
    self.byr != "" && self.iyr != "" && self.eyr != "" && self.hgt != "" && self.hcl != "" && self.ecl != "" && self.pid != ""
  }

  pub fn valid_2(&self) -> bool {
    self.valid() && self.valid_byr() && self.valid_iyr() && self.valid_eyr() && self.valid_hgt() && self.valid_hcl() && self.valid_ecl() && self.valid_pid()
  }

  fn get_values(input: &str) -> HashMap<&str, &str> {
    let values = input.split("\n");
    let mut values_map = HashMap::new();

    for val in values {
      let temp = val.split(" ");
      for t in temp {
        let value: Vec<&str> = t.split(":").collect();
        values_map.insert(value[0], value[1]);
      }
    }

    values_map
  }

  fn valid_byr(&self) -> bool {
    let byr = self.byr.parse::<i32>().unwrap_or(0);

    byr >= 1920 && byr <= 2002
  }

  fn valid_iyr(&self) -> bool {
    let iyr = self.iyr.parse::<i32>().unwrap_or(0);

    iyr >= 2010 && iyr <= 2020
  }

  fn valid_eyr(&self) -> bool {
    let eyr = self.eyr.parse::<i32>().unwrap_or(0);

    eyr >= 2020 && eyr <= 2030
  }

  fn valid_hgt(&self) -> bool {
    let re = Regex::new(r"^(\d{2,3})(cm|in)").unwrap();

    if !re.is_match(&self.hgt) {
      return false;
    }

    let cap = re.captures(&self.hgt).unwrap();

    let height = cap[1].parse::<i32>().unwrap();
  
    match &cap[2] {
      "cm" => height >= 150 && height <= 193,
      "in" => height >= 59 && height <= 76,
      _ => false
    }
  }

  fn valid_hcl(&self) -> bool {
    let re = Regex::new(r"^#[0-9a-f]{6}$").unwrap();

    re.is_match(&self.hcl)
  }

  fn valid_ecl(&self) -> bool {
    let valid_options = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];

    valid_options.contains(&&self.ecl[..])
  }

  fn valid_pid(&self) -> bool {
    let re = Regex::new(r"^[0-9]{9}$").unwrap();

    re.is_match(&self.pid)
  }
}