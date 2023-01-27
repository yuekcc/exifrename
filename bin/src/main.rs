use std::env;
use std::path::{Path, PathBuf};
use std::process::Command;

fn detect_python(install_dir: &Path) -> String {
    #[cfg(target_os = "windows")]
    let cmd_name = "python.exe";

    #[cfg(not(target_os = "windows"))]
    let cmd_name = "python";

    let local_python = install_dir.join("runtime").join(cmd_name);
    if local_python.exists() {
        local_python.to_str().unwrap().to_string()
    } else {
        "python".to_string()
    }
}

fn main() {
    let work_dir = env::current_dir().unwrap();

    let args: Vec<String> = env::args().collect();

    let exe = PathBuf::from(&args[0]);
    let install_dir = exe.parent().unwrap();

    let cli_args = &args[1..];

    let python_cmd = detect_python(install_dir);
    println!("using python: {}", &python_cmd);

    Command::new(python_cmd)
        .current_dir(work_dir)
        .arg(install_dir)
        .args(cli_args)
        .spawn()
        .expect("failed to launch");
}
