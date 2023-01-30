use std::path::{Path, PathBuf};
use std::process::{self, Command};
use std::{env, vec};

fn find_python(install_dir: &Path) -> PathBuf {
    #[cfg(target_os = "windows")]
    let cmd_names = vec!["runtime/python.exe", "python.exe"];

    #[cfg(not(target_os = "windows"))]
    let cmd_names = vec!["runtime/python", "runtime/python3", "python", "python3"];

    cmd_names
        .iter()
        .map(|name| install_dir.join(name))
        .find(|p| p.exists())
        .unwrap_or(PathBuf::from("python"))
}

fn start_app(python_exe: &Path, work_dir: &Path, install_dir: &Path, cli_args: &[String]) {
    let mut proc = {
        Command::new(python_exe)
            .arg(install_dir)
            .args(cli_args)
            .current_dir(work_dir)
            .spawn()
            .expect("failed to launch python script")
    };

    let exit_code = proc.wait().expect("app isn't running");
    if exit_code.success() {
        process::exit(0);
    } else {
        process::exit(exit_code.code().unwrap_or(-1));
    }
}

fn main() {
    let work_dir = env::current_dir().unwrap();

    let mut args = env::args();
    let starter = args.next().unwrap();
    let cli_args = args.collect::<Vec<String>>();

    let starter_path = PathBuf::from(&starter);
    let install_dir = starter_path.parent().unwrap();

    let python_exe = find_python(install_dir);
    println!("using python: {}", python_exe.display());

    start_app(&python_exe, &work_dir, install_dir, &cli_args);
}
