pub struct PartOne;
pub struct PartTwo;

impl PartOne {
  pub fn solve(input: &str) -> i32 {
    let lines: Vec<i32> = input.lines().map(|n| n.parse::<i32>().unwrap_or(0)).collect();

    for x in &lines {
      for y in &lines {
        if x + y == 2020 {
          return x * y;
        }
      }
    }

    -1
  }
}

#[test]
fn example_1() {
  let input = "1721\n979\n366\n299\n675\n1456";
  assert_eq!(PartOne::solve(input), 514579);
}

impl PartTwo {
  pub fn solve(input: &str) -> i32 {
    let lines: Vec<i32> = input.lines().map(|n| n.parse::<i32>().unwrap_or(0)).collect();

    for x in &lines {
      for y in &lines {
        for z in &lines {
          if x + y + z == 2020 {
            return x * y * z;
          }
        }
      }
    }

    -1
  }
}

#[test]
fn example_2() {
  let input = "1721\n979\n366\n299\n675\n1456";
  assert_eq!(PartTwo::solve(input), 241861950);
}