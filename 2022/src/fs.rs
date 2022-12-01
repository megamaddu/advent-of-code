use std::{fs::File, io::Read};

pub(crate) fn read_input(path: &str) -> String {
    let mut file = String::new();
    File::open(path).unwrap().read_to_string(&mut file).unwrap();
    file
}
