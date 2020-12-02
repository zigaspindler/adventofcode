use regex::Regex;

pub struct PartOne;
pub struct PartTwo;

impl PartOne {
  pub fn solve(input: &str) -> i32 {
    let mut valid_count = 0;

    let re = Regex::new(r"(\d{1,2})-(\d{1,2}) ([a-z]): (.+)").unwrap();
    for line in input.lines() {
      let cap = re.captures(line).unwrap();

      let min = cap[1].parse::<i32>().unwrap_or(0);
      let max = cap[2].parse::<i32>().unwrap_or(0);
      let target_char = cap[3].chars().next().unwrap();

      let mut char_count = 0;

      for c in cap[4].chars() {
        if c == target_char {
          char_count = char_count + 1;
        }
      }

      if char_count >= min && char_count <= max {
        valid_count = valid_count + 1;
      }
    }

    valid_count
  }
}

#[test]
fn example_1() {
  let input = "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc";
  assert_eq!(PartOne::solve(input), 2);
}

impl PartTwo {
  pub fn solve(input: &str) -> i32 {
    let mut valid_count = 0;

    let re = Regex::new(r"(\d{1,2})-(\d{1,2}) ([a-z]): (.+)").unwrap();
    for line in input.lines() {
      let cap = re.captures(line).unwrap();

      let first = cap[1].parse::<usize>().unwrap_or(0);
      let second = cap[2].parse::<usize>().unwrap_or(0);
      let target_char = cap[3].chars().next().unwrap();

      let first_char = cap[4].chars().nth(first - 1).unwrap();
      let second_char = cap[4].chars().nth(second - 1).unwrap();

      if first_char != second_char && (first_char == target_char || second_char == target_char) {
        valid_count = valid_count + 1;
      }
    }

    valid_count
  }
}

#[test]
fn example_2() {
  let input = "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc";
  assert_eq!(PartTwo::solve(input), 1);
}
