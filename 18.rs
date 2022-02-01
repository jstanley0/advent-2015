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

fn iterate(grid: &Vec<Vec<char>>) -> Vec<Vec<char>> {
    let mut result = Vec::<Vec<char>>::with_capacity(grid.len());
    for y in 0..grid.len() {
        let mut row = Vec::<char>::with_capacity(grid[y].len());
        for x in 0..grid[y].len() {
            let n = count_neighbors(grid, x, y);
            if grid[y][x] == '#' {
                row.push( if n == 2 || n == 3 { '#' } else { '.' } );
            } else {
                row.push( if n == 3 { '#' } else { '.' } );
            }
        }
        result.push(row);
    }
    result
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

    for _ in 0..iters {
        grid = iterate(&grid);
    }

    println!("{}", grid.iter().fold(0, |n, row| n + row.iter().fold(0, |n, c| n + if c == &'#' { 1 } else { 0 })));
    Ok(())
}
