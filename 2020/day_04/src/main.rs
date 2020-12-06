use std::fs;

use day_04::{PartOne, PartTwo};

fn main() {
    let input = fs::read_to_string("resources/input.txt").expect("Something went wrong reading the file");

    let result_part_one = PartOne::solve(&input);
    let result_part_two = PartTwo::solve(&input);

    println!("Part 1: {}", result_part_one);
    println!("Part 2: {}", result_part_two);
}
