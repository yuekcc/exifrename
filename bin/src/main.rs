use std::os::windows::process::CommandExt;
use std::path::{Path, PathBuf};
use std::process::Command;
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

const CREATE_UNICODE_ENVIRONMENT: u32 = 0x00000400;
const CREATE_NEW_PROCESS_GROUP: u32 = 0x00000200;

fn start_pyapp(pyexec: &str, install_dir: &Path, cli_args: &[String], work_dir: &Path) {
    #[cfg(target_os = "windows")]
    {
        Command::new(pyexec)
            .creation_flags(CREATE_NEW_PROCESS_GROUP | CREATE_UNICODE_ENVIRONMENT) // windows 平台专用
            .arg(install_dir)
            .args(cli_args)
            .current_dir(work_dir)
            .spawn()
            .expect("failed to launch python script");
    };

    #[cfg(not(target_os = "windows"))]
    {
        Command::new(pyexec)
            .arg(install_dir)
            .args(cli_args)
            .current_dir(work_dir)
            .spawn()
            .expect("failed to launch python script");
    };
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
