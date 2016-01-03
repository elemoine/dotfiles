#-*- mode: shell-script;-*-

# Programmed completion for bash to use virsh
# Copyright 2007 Red Hat Inc.
# David Lutterkort <dlutter redhat com>

_virsh_file()
{
    COMPREPLY=( ${COMPREPLY[ ]:-} $( compgen -f -- "$cur" ) )
    echo $( compgen -d -- "$cur" ) | while read d ; do 
    COMPREPLY=( ${COMPREPLY[ ]:-} "$d/" )
    done
}

_virsh_domain()
{
    domains=$(virsh --readonly --quiet list --all | cut -b 5- | cut -d ' ' -f 1)
    COMPREPLY=( ${COMPREPLY[ ]:-} $(compgen -W "$domains" -- $cur) )
}

_virsh_network()
{
    networks=$(virsh --readonly --quiet net-list --all | cut -d ' ' -f 1)
    COMPREPLY=( ${COMPREPLY[ ]:-} $(compgen -W "$networks" -- $cur) )
}

_virsh_opts()
{
    if [[ ${cur:0:1} == "-" ]] ; then
        COMPREPLY=( ${COMPREPLY[ ]:-} $( compgen -W "$*" -- $cur ) )
    fi
}

_virsh_completion ()
{
    local cur prev cmd cmds ind opts cmdind comdomfile

    COMPREPLY=()
    cmds=$(virsh --readonly --quiet help | sed -e '1,2d;$d;s/\s\+/ /g;s/^\s\+//' | cut -d ' ' -f 1 2>/dev/null)
    opts="-c --connect -r --readonly -d --debug -h --help -q --quiet -t --timing -l --log -v --version"
    # Find the command
    for ind in $( seq 1 $(($COMP_CWORD-1)) ) ; do
        if [[ ${COMP_WORDS[ind]:0:1} != "-" ]] ; then
            cmd=${COMP_WORDS[ind]}
            cmdind=$(($COMP_CWORD-$ind))
            break
        fi
    done
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [[ -z $cmd ]] ; then
        if [[ ${cur:0:1} == "-" ]] ; then
            COMPREPLY=( $(compgen -W "$opts" -- $cur) )
        else
            case $prev in
                -c|--connect)
                    # Nothing to complete
                    ;;
                -d|--debug)
                    COMPREPLY=( $(compgen -W "0 1 2 3 4 5" -- $cur) )
                    ;;
                -l|--log)
                    _virsh_file
                    ;;
                *)
                    COMPREPLY=( $(compgen -W "$cmds" -- $cur) )
                    ;;
            esac
        fi
        return 0
    fi

    comdomfile=(: _virsh_domain _virsh_file)
    case $cmd in
        help)
            COMPREPLY=( $(compgen -W "$cmds" -- $cur) )
            ;;
        attach-device|detach-device)
            ${comdomfile[$cmdind]}
            ;;
        attach-disk|attach-interface|detach-disk|detach-interface)
            if [[ $cmdind -eq 1 ]] ; then
                _virsh_domain
            fi
            ;;
        autostart)
            _virsh_domain
            _virsh_opts --disable
            ;;
        console)
            _virsh_domain
            ;;
        create|define)
            _virsh_file
            ;;
        destroy)
            _virsh_domain
            ;;
        domblkstat)
            if [[ $cmdind -eq 1 ]] ; then
                _virsh_domain
            fi
            ;;
        domid)
            _virsh_domain
            ;;
        domifstat)
            if [[ $cmdind -eq 1 ]] ; then
                _virsh_domain
            fi
            ;;
        dominfo|domname|domstate|domuuid)
            _virsh_domain
            ;;
        dump)
            ${comdomfile[$cmdind]}
            ;;
        dumpxml)
            _virsh_domain
            ;;
        migrate)
            _virsh_domain
            _virsh_opts --live
            ;;
        list)
            COMPREPLY=( $(compgen -W "--inactive --all" -- $cur) )
            ;;
        net-autostart)
            _virsh_network
            _virsh_opts --disable
            ;;
        net-create|net-define)
            _virsh_file
            ;;
        net-destroy|net-dumpxml)
            _virsh_network
            ;;
        net-list)
            COMPREPLY=( $(compgen -W "--inactive --all" -- $cur) )
            ;;
        net-name|net-start|net-undefine|net-uuid)
            _virsh_network
            ;;
        reboot)
            _virsh_domain
            ;;
        restore)
            _virsh_file
            ;;
        resume)
            _virsh_domain
            ;;
        save)
            ${comdomfile[$cmdind]}
            ;;
        schedinfo)
            _virsh_domain
            _virsh_opts --weight --cap
            ;;
        setmaxmem|setmem|setvcpus)
            if [[ $cmdind -eq 1 ]] ; then
                _virsh_domain
            fi
            ;;
        shutdown|start|suspend)
            _virsh_domain
            ;;
        ttyconsole|undefine|vcpuinfo)
            _virsh_domain
            ;;
        vcpupin)
            if [[ $cmdind -eq 1 ]] ; then
                _virsh_domain
            fi
            ;;
        vncdisplay)
            _virsh_domain
            ;;
    esac
    return 0
}

[ ${BASH_VERSINFO[0]} '>' 2 -o \
    ${BASH_VERSINFO[0]}  =  2 -a ${BASH_VERSINFO[1]} '>' 04 ] \
    && _virsh_complete_opt="-o filenames"
complete $_virsh_complete_opt -F _virsh_completion virsh
