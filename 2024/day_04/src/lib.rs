pub fn part_01(input: &str) -> i32 {
    let mut total = 0;
    let parsed_input = parse_input(&input);
    let width = parsed_input[0].len();
    let height = parsed_input.len();
    for (i, line) in parsed_input.iter().enumerate() {
        for (j, char) in line.iter().enumerate() {
            if *char != 'X' {
                continue;
            }
            // right
            if j + 3 < width && line[j + 1] == 'M' && line[j + 2] == 'A' && line[j + 3] == 'S' {
                total += 1;
            }
            // left
            if j >= 3 && line[j - 1] == 'M' && line[j - 2] == 'A' && line[j - 3] == 'S' {
                total += 1;
            }
            // up
            if i >= 3
                && parsed_input[i - 1][j] == 'M'
                && parsed_input[i - 2][j] == 'A'
                && parsed_input[i - 3][j] == 'S'
            {
                total += 1;
            }
            // down
            if i + 3 < height
                && parsed_input[i + 1][j] == 'M'
                && parsed_input[i + 2][j] == 'A'
                && parsed_input[i + 3][j] == 'S'
            {
                total += 1;
            }
            // up right
            if i >= 3
                && j + 3 < width
                && parsed_input[i - 1][j + 1] == 'M'
                && parsed_input[i - 2][j + 2] == 'A'
                && parsed_input[i - 3][j + 3] == 'S'
            {
                total += 1;
            }
            // up left
            if i >= 3
                && j >= 3
                && parsed_input[i - 1][j - 1] == 'M'
                && parsed_input[i - 2][j - 2] == 'A'
                && parsed_input[i - 3][j - 3] == 'S'
            {
                total += 1;
            }
            // down right
            if i + 3 < height
                && j + 3 < width
                && parsed_input[i + 1][j + 1] == 'M'
                && parsed_input[i + 2][j + 2] == 'A'
                && parsed_input[i + 3][j + 3] == 'S'
            {
                total += 1;
            }
            // down left
            if i + 3 < height
                && j >= 3
                && parsed_input[i + 1][j - 1] == 'M'
                && parsed_input[i + 2][j - 2] == 'A'
                && parsed_input[i + 3][j - 3] == 'S'
            {
                total += 1;
            }
        }
    }

    total
}

pub fn part_02(input: &str) -> i32 {
    let mut total = 0;
    let parsed_input = parse_input(&input);
    for i in 1..parsed_input.len() - 1 {
        for j in 1..parsed_input[i].len() - 1 {
            if parsed_input[i][j] != 'A' {
                continue;
            }
            // bottom left to top right
            if !((parsed_input[i + 1][j - 1] == 'S' && parsed_input[i - 1][j + 1] == 'M')
                || (parsed_input[i + 1][j - 1] == 'M' && parsed_input[i - 1][j + 1] == 'S'))
            {
                continue;
            }

            // top left to bottom right
            if (parsed_input[i - 1][j - 1] == 'S' && parsed_input[i + 1][j + 1] == 'M')
                || (parsed_input[i - 1][j - 1] == 'M' && parsed_input[i + 1][j + 1] == 'S')
            {
                total += 1;
            }
        }
    }

    total
}

fn parse_input(input: &str) -> Vec<Vec<char>> {
    let mut output: Vec<Vec<char>> = vec![];

    for line in input.lines() {
        let new_line = line.chars().collect::<Vec<char>>();
        output.push(new_line);
    }

    output
}
