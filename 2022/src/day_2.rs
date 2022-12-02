use std::cmp::Ordering;

use itertools::Itertools;

use crate::fs;

pub(crate) fn go() {
    let input = fs::read_input("inputs/day_2.txt");

    let rounds = input.lines().flat_map(|line| {
        line.split_whitespace()
            .tuples::<(_, _)>()
            .map_into::<Round>()
    });
    let player_score = rounds.fold(0u64, |score, Round(o, p)| score + u64::from(p.move_score()) + u64::from(p.round_score(&o)));
    println!("Player score: {}", player_score)
}

#[derive(Eq, PartialEq, Debug)]
enum Move {
    Rock,
    Paper,
    Scissors,
}

impl Ord for Move {
    fn cmp(&self, other: &Self) -> Ordering {
        use Move::{Paper, Rock, Scissors};
        use Ordering::{Equal, Greater, Less};
        if self == other {
            return Equal;
        }
        match (self, other) {
            (Rock, Scissors) => Greater,
            (Paper, Rock) => Greater,
            (Scissors, Paper) => Greater,
            _ => Less,
        }
    }
}

impl PartialOrd for Move {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

#[derive(Debug)]
struct PlayerMove(Move);

impl From<&str> for PlayerMove {
    fn from(s: &str) -> Self {
        use Move::{Paper, Rock, Scissors};
        match s {
            "X" => PlayerMove(Rock),
            "Y" => PlayerMove(Paper),
            "Z" => PlayerMove(Scissors),
            _ => panic!("Invalid player move: {}", s),
        }
    }
}

#[derive(Debug)]
struct OpponentMove(Move);

impl From<&str> for OpponentMove {
    fn from(s: &str) -> Self {
        use Move::{Paper, Rock, Scissors};
        match s {
            "A" => OpponentMove(Rock),
            "B" => OpponentMove(Paper),
            "C" => OpponentMove(Scissors),
            _ => panic!("Invalid opponent move: {}", s),
        }
    }
}

#[derive(Debug)]
struct Round(OpponentMove, PlayerMove);

impl From<(&str, &str)> for Round {
    fn from((o, p): (&str, &str)) -> Self {
        Round(o.into(), p.into())
    }
}

impl PlayerMove {
    fn move_score(&self) -> u8 {
        use Move::{Paper, Rock, Scissors};
        match self.0 {
            Rock => 1,
            Paper => 2,
            Scissors => 3,
        }
    }

    fn round_score(&self, opponent_move: &OpponentMove) -> u8 {
        use Ordering::{Equal, Greater, Less};
        match self.0.cmp(&opponent_move.0) {
            Greater => 6,
            Equal => 3,
            Less => 0,
        }
    }
}
