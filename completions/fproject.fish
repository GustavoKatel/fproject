
function __fish_fproject_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -c fproject -d "Manage your personal projects directory"

complete -c fproject -n '__fish_use_subcommand' -fa new -d "New project"

complete -c fproject -n '__fish_use_subcommand' -xa "open" -d "Open project"
complete -f -c fproject -n "__fish_fproject_using_command open" -d "Open project" -a "(ls (cat ~/.config/fproject/projects_path))"

complete -c fproject -n '__fish_use_subcommand' -xa "path" -d "Set the projects path"
