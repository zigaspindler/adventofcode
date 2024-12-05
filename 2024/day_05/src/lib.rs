use std::collections::{HashMap, HashSet};

pub fn part_01(input: &str) -> i32 {
    let mut total = 0;

    let (rules, updates) = parse_input(input);

    for update in updates {
        if valid_update(&update, &rules) {
            let middle = update.len() / 2;
            total += update[middle];
        }
    }

    total
}

pub fn part_02(input: &str) -> i32 {
    let mut total = 0;

    total
}

fn valid_update(update: &Vec<i32>, rules: &HashMap<i32, Vec<i32>>) -> bool {
    for (i, number) in update.iter().enumerate() {
        if i == 0 {
            continue;
        }
        let ancestors: HashSet<i32> = HashSet::from_iter(update[0..i].to_vec());
        let number_rules = HashSet::from_iter(rules.get(&number).unwrap_or(&Vec::new()).to_vec());
        let intersection = ancestors.intersection(&number_rules);
        if intersection.count() > 0 {
            return false;
        }
    }

    true
}

fn parse_input(input: &str) -> (HashMap<i32, Vec<i32>>, Vec<Vec<i32>>) {
    let mut rules: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut updates = Vec::new();

    let mut parsing_rules = true;
    for line in input.lines() {
        if line.is_empty() {
            parsing_rules = false;
            continue;
        }

        if parsing_rules {
            let (a, b) = parse_rule(line);
            match rules.get_mut(&a) {
                Some(rules) => {
                    rules.push(b);
                }
                None => {
                    rules.insert(a, vec![b]);
                }
            }
        } else {
            updates.push(parse_update(line));
        }
    }

    (rules, updates)
}

fn parse_rule(line: &str) -> (i32, i32) {
    let (a, b) = line.split_once('|').unwrap();

    (a.parse().unwrap(), b.parse().unwrap())
}

fn parse_update(line: &str) -> Vec<i32> {
    line.split(',')
        .map(|x| x.parse().unwrap())
        .collect::<Vec<i32>>()
}
