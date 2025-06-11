function th -d "Toggles history"
    if ! set -q fish_history
        set -g fish_history ''
    else
        set -eg fish_history
    end
end

function mcd -d "Make + cd"
    mkdir -p $argv[1] && cd $argv[1]
end
