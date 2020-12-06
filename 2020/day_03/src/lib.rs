pub struct PartOne;
pub struct PartTwo;

impl PartOne {
  pub fn solve(input: &str) -> i64 {
    return get_hit_trees(input, 3, 1);
  }
}

#[test]
fn example_1() {
  let input = std::fs::read_to_string("resources/example.txt").expect("Something went wrong reading the file");
  assert_eq!(PartOne::solve(&input), 7);
}

impl PartTwo {
  pub fn solve(input: &str) -> i64 {
    get_hit_trees(input, 1, 1) * get_hit_trees(input, 3, 1) *
    get_hit_trees(input, 5, 1) * get_hit_trees(input, 7, 1) *
    get_hit_trees(input, 1, 2)
  }
}

#[test]
fn example_2() {
  let input = std::fs::read_to_string("resources/example.txt").expect("Something went wrong reading the file");
  assert_eq!(PartTwo::solve(&input), 336);
}

fn get_hit_trees(input: &str, right: usize, down: usize) -> i64 {
  let mut trees_hit = 0;
  let lines_count = input.lines().count();

  for (i, j) in (0..lines_count).step_by(down).enumerate() {
    let line = input.lines().nth(j).unwrap();
    let pos = (i * right) % line.chars().count();

    if line.chars().nth(pos).unwrap() == '#' {
      trees_hit = trees_hit + 1;
    }
  }

  trees_hit
}