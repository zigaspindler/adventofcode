use day_02::{part_01, part_02};
use std::fs;

fn main() {
    let input = open_file("resources/input.txt");

    println!("Part 1: {}", part_01(&input));
    println!("Part 2: {}", part_02(&input));
}

fn open_file(filename: &str) -> String {
    fs::read_to_string(filename).expect("Something went wrong reading the file")
}

#[test]
fn part_01_example() {
    let input = open_file("resources/example_1.txt");

    assert_eq!(part_01(&input), 2);
}
#[test]
fn part_02_example() {
    let input = open_file("resources/example_1.txt");

    assert_eq!(part_02(&input), 4);
}
