use regex::Regex;

pub fn part_01(input: &str) -> i32 {
    let mut total = 0;
    let re = Regex::new(r"mul\((\d+),(\d+)\)").unwrap();

    for line in input.lines() {
        for (_, [a, b]) in re.captures_iter(line).map(|c| c.extract()) {
            total += a.parse::<i32>().unwrap() * b.parse::<i32>().unwrap();
        }
    }

    total
}

pub fn part_02(input: &str) -> i32 {
    let mut total = 0;
    let re = Regex::new(r"mul\((?<a>\d+),(?<b>\d+)\)|(?<start>do\(\))|(?<stop>don't\(\))").unwrap();

    let mut enabled = true;
    for line in input.lines() {
        for capture in re.captures_iter(line) {
            match capture.name("stop") {
                Some(_) => {
                    enabled = false;
                    continue;
                }
                None => (),
            }
            match capture.name("start") {
                Some(_) => {
                    enabled = true;
                    continue;
                }
                None => (),
            }
            if !enabled {
                continue;
            }
            let a = capture.name("a").unwrap().as_str().parse::<i32>().unwrap();
            let b = capture.name("b").unwrap().as_str().parse::<i32>().unwrap();
            total += a * b;
        }
    }

    total
}
