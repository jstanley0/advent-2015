use std::io::BufRead;

fn count_neighbors(grid: &Vec<Vec<char>>, x: usize, y: usize) -> i32 {
    let y0 = if y > 0 { y - 1 } else { y };
    let y1 = if y < grid.len() - 1 { y + 1 } else { y };
    let x0 = if x > 0 { x - 1 } else { x };
    let x1 = if x < grid[y].len() - 1 { x + 1 } else { x };
    let mut count = 0;
    for j in y0..=y1 {
        for i in x0..=x1 {
            if i == x && j == y {
                continue;
            }
            if grid[j][i] == '#' {
                count += 1;
            }
        }
    }
    count
}

fn iterate(grid: &mut Vec<Vec<char>>, scratch: &mut Vec<Vec<char>>) {
    for y in 0..grid.len() {
        for x in 0..grid[y].len() {
            scratch[y][x] = grid[y][x];
        }
    }
    for y in 0..grid.len() {
        for x in 0..grid[y].len() {
            let n = count_neighbors(scratch, x, y);
            grid[y][x] = if scratch[y][x] == '#' {
                if n == 2 || n == 3 { '#' } else { '.' }
            } else {
                if n == 3 { '#' } else { '.' }
            }
        }
    }
}

fn stick_on(grid: &mut Vec<Vec<char>>) {
    let h = grid.len();
    let w = grid[0].len();
    grid[0][0] = '#';
    grid[h - 1][0] = '#';
    grid[0][w - 1] = '#';
    grid[h - 1][w - 1] = '#';
}

fn main() -> std::io::Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 3 {
        println!("usage: {} file iterations", args[0]);
        return Ok(());
    }
    let iters = args[2].parse::<i32>().unwrap();
    let file = std::fs::File::open(&args[1])?;
    let mut reader = std::io::BufReader::new(&file);
    let mut grid = Vec::<Vec<char>>::new();
    let mut line = String::new();
    loop {
        line.clear();
        let sz = reader.read_line(&mut line)?;
        if sz == 0 {
            break;
        }
        grid.push(line.trim_end().chars().collect());
    }

    let mut scratch = grid.clone();
    for _ in 0..iters {
        stick_on(&mut grid);
        iterate(&mut grid, &mut scratch);
    }
    stick_on(&mut grid);

    println!("{}", grid.iter().fold(0, |n, row| n + row.iter().fold(0, |n, c| n + if c == &'#' { 1 } else { 0 })));
    Ok(())
}
