# Yarn
set -l yarnrc $HOME/.yarnrc
set -l config_dir $HOME/.local/share/yarn

if command -sq yarn
  # Keep global binaries global
  if test -f $yarnrc && ! grep -q prefix $yarnrc
    yarn config set prefix $config_dir
    mkdir -p $config_dir/bin
  end

  fish_add_path -g $config_dir/bin
end
