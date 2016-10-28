function __fproject_help

  echo "# Opens a project";
  echo "fproject open PROJECT_NAME";

  echo "# Creates a new project";
  echo "fproject new [PROJECT_NAME]";

  echo "# Set the default project path";
  echo "fproject path PATH";

  echo "# Show this help";
  echo "fproject help";

end

function __fproject_test_config

  set -l config_path "$HOME/.config/fproject";

  if not test -e $config_path
    mkdir -p $config_path;
    return 1;
  end

  if not test -e $config_path"/projects_path"
    echo -n "Projects path is not set.\n Use";
    set_color green; echo " fproject path DIRECTORY"; set_color normal;
    return 1;
  end

  return 0;

end

function __fproject_set_path

  set -l config_path "$HOME/.config/fproject";

  if not test -e $config_path
    mkdir -p $config_path;
  end

  if [ (count $argv) -lt 2 ]
    echo "See help for more info";
    return 1;
  end

  echo $argv[2] > $config_path"/projects_path";

end

function __fproject_get_path

  set -l config_path "$HOME/.config/fproject";

  cat $config_path"/projects_path";

end

function __fproject_new

  set -l name "";
  if [ (count $argv) -lt 2 ]
    read -p "set_color green; echo -n Project name; set_color normal; echo -n \": \"" name;
  else
    set name $argv[2];
  end

  if test -z $name
    echo "Empty name. Quiting...";
    return 1;
  end

  set -l project_path (__fproject_get_path)"/$name";
  if test -e $project_path
    echo "Already exist.";
    cd $project_path;
  else

    mkdir -p $project_path; and cd $project_path;

  end

end

function __fproject_open

  if [ (count $argv) -lt 2 ]
    echo "See help for more info";
    return 1;
  end

  set -l project_path (__fproject_get_path)"/$argv[2]";
  if test -e $project_path
    cd $project_path;
  else
    set_color red; echo -n "$argv[2]";
    set_color normal; echo -n " does not seem to exist in ";
    set_color green; echo "$project_path"
    set_color normal;
  end

end

function fproject

  if [ (count $argv) -eq 0 ]
    __fproject_help;
    return 1
  end # if

  switch $argv[1]
    case new
      if not __fproject_test_config; return 1; end
      __fproject_new $argv;

    case open
      if not __fproject_test_config; return 1; end
      __fproject_open $argv;

    case path
      __fproject_set_path $argv;

  end # switch

end # function
