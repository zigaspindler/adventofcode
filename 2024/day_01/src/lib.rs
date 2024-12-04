pub fn part_01(input: &str) -> i32 {
    let mut total = 0;

    let (mut left, mut right) = parse_input(input);

    left.sort();
    right.sort();

    for (_i, (l_val, b_val)) in left.iter().zip(right.iter()).enumerate() {
        total += i32::abs(*l_val - *b_val);
    }

    total
}

pub fn part_02(input: &str) -> i32 {
    let mut total = 0;

    let (left, right) = parse_input(input);

    for val_l in left.iter() {
        let count = right.iter().filter(|&val_r| *val_l == *val_r).count() as i32;
        total += *val_l * count;
    }

    total
}

fn parse_input(input: &str) -> (Vec<i32>, Vec<i32>) {
    let mut left = Vec::new();
    let mut right = Vec::new();
    for line in input.lines() {
        let parts = line.split_whitespace().collect::<Vec<_>>();
        left.push(parts[0].parse::<i32>().unwrap());
        right.push(parts[1].parse::<i32>().unwrap());
    }

    (left, right)
}