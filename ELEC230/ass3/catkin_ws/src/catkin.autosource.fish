# ~/.config/fish/conf.d/catkin.autosource.fish

function catkinSource --on-variable PWD
    status --is-command-substitution; and return
    if test -e ".catkin_workspace"; or test -e ".catkin_tools"
        if test -e "devel_isolated/setup.bash"
            bass source devel_isolated/setup.bash
            echo "devel_isolated/setup.bash sourced"
        else if test -e "devel/setup.bash"
            bass source devel/setup.bash
            echo "devel/setup.bash sourced"                  
        end    
    end
end