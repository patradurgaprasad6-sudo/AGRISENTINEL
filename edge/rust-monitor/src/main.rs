fn classify_moisture(value: f32) -> Result<&'static str, &'static str> {
    if !(0.0..=100.0).contains(&value) {
        return Err("moisture must be in range 0..=100");
    }
    Ok(if value < 25.0 { "DRY_REVIEW" } else if value > 42.0 { "WET_REVIEW" } else { "NORMAL_MONITORING" })
}

fn main() {
    let sample = 24.5_f32;
    match classify_moisture(sample) {
        Ok(state) => println!("{{\"moisture\":{sample},\"state\":\"{state}\"}}"),
        Err(message) => eprintln!("Invalid reading: {message}"),
    }
}
