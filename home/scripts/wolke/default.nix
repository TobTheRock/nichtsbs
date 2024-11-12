{ pkgs, config, ... }:

let
  syncDirStr = builtins.concatStringsSep " "
    (map (x: ''"${x}"'') config.var.wolke.syncDirs);
  mountDirStr = builtins.concatStringsSep " "
    (map (x: ''"${x}"'') config.var.wolke.mountDirs);
  remoteName = config.var.wolke.remoteName;
  rootDir = config.var.wolke.rootDir;
  wolke = pkgs.writeShellScriptBin "wolke"
    # bash
    ''
      syncDirs=( ${syncDirStr} )
      mountDirs=( ${mountDirStr} )

      function exec() {
        $@
      }

      function ui(){
        DEFAULT_ICON="󰘳"

        # "icon;name;command"[]
        apps=(
          "󰑓;Sync;wolke sync"
          "󰦗;Check;wolke check"
          ";List;wolke list"
          ";Mount;wolke mount"
        )
        # Apply default icons if empty:
        for i in "''${!apps[@]}"; do
          apps[i]=$(echo "''${apps[i]}" | sed 's/^;/'$DEFAULT_ICON';/')
        done

        fzf_result=$(printf "%s\n" "''${apps[@]}" | awk -F ';' '{print $1" "$2}' | fzf)
        [[ -z $fzf_result ]] && exit 0
        fzf_result=''${fzf_result/ /;}
        line=$(printf "%s\n" "''${apps[@]}" | grep "$fzf_result")
        command=$(echo "$line" | sed 's/^[^;]*;//;s/^[^;]*;//')

        exec "$command"
        exit 0
      }

      function rclone_list(){
        rclone lsd ${remoteName}:
      }

      function rclone_check(){
        for dir in "''${syncDirs[@]}"; do
          echo "#-- Checking $dir"
          rclone check ${rootDir}/$dir ${remoteName}:$dir --progress --stats-one-line --stats=5s  --combined --quiet 
        done
      }

      function rclone_sync(){
        for dir in "''${syncDirs[@]}"; do
          echo "#-- Syncing $dir"
          rclone sync ${rootDir}/$dir ${remoteName}:$dir --progress --stats-one-line --stats=5s --quiet --transfers=2 --checkers=4 
        done
      }

      function rclone_mount(){
        for dir in "''${mountDirs[@]}"; do
          echo "#-- Mounting $dir"
          rclone mount ${remoteName}:$dir ${rootDir}/$dir --vfs-cache-mode full --allow-non-empty  --daemon 
        done
      }

      [[ $1 == "" ]] && ui

      if [[ $1 == "sync" ]];then
        rclone_sync
      elif [[ $1 == "list" ]];then
        rclone_list
      elif [[ $1 == "check" ]];then
        rclone_check
      elif [[ $1 == "mount" ]];then
        rclone_mount
      else
        echo "Unknown argument"
      fi

    '';
in { home.packages = with pkgs; [ rclone wolke ]; }
