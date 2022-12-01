use std::{fmt::Display, iter::Sum};

use itertools::Itertools;

use crate::fs;

pub(crate) fn go() {
    let elf_groups = fs::read_input("inputs/day_1.txt");
    let elfs = elf_groups
        .trim()
        .split("\n\n")
        .map(|calorie_group| Elf {
            total_calories: calorie_group
                .lines()
                .map(Calories::parse)
                .sum(),
        });
    let top_three_elfs_by_calories = elfs
        .sorted_by_key(|elf| u64::MAX - elf.total_calories.0)
        .take(3);
    let calorie_total = top_three_elfs_by_calories
        .map(|elf| elf.total_calories)
        .sum::<Calories>();
    println!("Highest calorie elves hold {} in total", calorie_total)
}

struct Elf {
    total_calories: Calories,
}

struct Calories(u64);

impl Calories {
    fn parse(str: &str) -> Calories {
        match str.parse::<u64>() {
            Ok(calories) => Calories(calories),
            Err(e) => {
                println!("Invalid calorie string: {:?}\n{:?}", str, e);
                panic!()
            }
        }
    }
}

impl Sum for Calories {
    fn sum<I: Iterator<Item = Self>>(iter: I) -> Self {
        Calories(iter.map(|c| c.0).sum())
    }
}

impl Display for Calories {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{} calories", self.0)
    }
}
