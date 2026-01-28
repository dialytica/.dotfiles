if status is-interactive
    # Commands to run in interactive sessions can go here
end

# adding DOTENET_ROOT
export DOTNET_ROOT=/home/linuxbrew/.linuxbrew/opt/dotnet/libexec
# alias vim=nvim
alias vim=nvim
# starship init
starship init fish | source
