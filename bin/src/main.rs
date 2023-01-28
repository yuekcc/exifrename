use std::path::{Path, PathBuf};
use std::process::{self, Command};
use std::{env, vec};

fn find_python(install_dir: &Path) -> String {
    #[cfg(target_os = "windows")]
    let cmd_names = vec!["runtime/python.exe", "python.exe"];

    #[cfg(not(target_os = "windows"))]
    let cmd_names = vec!["runtime/python", "runtime/python3", "python", "python3"];

    cmd_names
        .iter()
        .find(|cmd_name: &&&str| install_dir.join(cmd_name).exists())
        .unwrap_or(&"python")
        .to_string()
}

fn start_pyapp(pyexec: &str, install_dir: &Path, cli_args: &[String], work_dir: &Path) {
    let mut command_line = vec![
        pyexec.to_string(),
        install_dir.to_str().unwrap().to_string(),
    ];
    command_line.extend_from_slice(cli_args);

    #[cfg(target_os = "windows")]
    let exit_code = {
        Command::new("cmd")
            .arg("/C")
            .arg(command_line.join(" "))
            .current_dir(work_dir)
            .spawn()
            .expect("failed to launch python script")
            .wait()
            .expect("the app isn't running")
    };

    #[cfg(not(target_os = "windows"))]
    let exit_code = {
        Command::new("sh")
            .arg("-c")
            .arg(command_line.join(" "))
            .current_dir(work_dir)
            .spawn()
            .expect("failed to launch python script")
            .wait()
            .expect("the app isn't running")
    };

    if exit_code.success() {
        process::exit(0);
    } else {
        process::exit(-1)
    }
}

fn main() {
    let work_dir = env::current_dir().unwrap();

    let mut args = env::args();
    let starter = args.next().unwrap();
    let cli_args = args.collect::<Vec<String>>();

    let starter_path = PathBuf::from(&starter);
    let install_dir = starter_path.parent().unwrap();

    let python_cmd = find_python(install_dir);
    println!("using python: {}", &python_cmd);

    start_pyapp(&python_cmd, install_dir, &cli_args, &work_dir);
}
