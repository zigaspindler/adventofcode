pub fn part_01(input: &str) -> i32 {
    let mut total = 0;
    let parsed_input = parse_input(input);

    for report in parsed_input {
        if valid_report(&report) {
            total += 1;
        }
    }

    total
}

pub fn part_02(input: &str) -> i32 {
    let mut total = 0;
    let parsed_input = parse_input(input);

    for report in parsed_input {
        for (index, _) in report.iter().enumerate() {
            let mut cloned_report = report.clone();
            cloned_report.remove(index);

            if valid_report(&cloned_report) {
                total += 1;
                break;
            }
        }
    }

    total
}

fn parse_input(input: &str) -> Vec<Vec<i32>> {
    let mut output: Vec<Vec<i32>> = vec![];

    for line in input.lines() {
        let values = line
            .split(' ')
            .collect::<Vec<&str>>()
            .iter()
            .map(|&x| x.parse::<i32>().unwrap())
            .collect::<Vec<i32>>();
        output.push(values);
    }

    output
}

fn valid_report(report: &Vec<i32>) -> bool {
    let mut diff = Vec::new();
    for r in report.windows(2) {
        diff.push(r[0] - r[1]);
    }

    (all_positive(&diff) || all_negative(&diff)) && all_in_range(&diff)
}

fn all_positive(numbers: &Vec<i32>) -> bool {
    let mut positive = true;
    for n in numbers.iter() {
        if *n > 0 {
            positive = false;
            break;
        }
    }
    positive
}

fn all_negative(numbers: &Vec<i32>) -> bool {
    let mut negative = true;
    for n in numbers.iter() {
        if *n < 0 {
            negative = false;
            break;
        }
    }
    negative
}

fn all_in_range(numbers: &Vec<i32>) -> bool {
    let mut in_range = true;
    for n in numbers.iter() {
        let abs_value = i32::abs(*n);
        if abs_value < 1 || abs_value > 3 {
            in_range = false;
            break;
        }
    }
    in_range
}
