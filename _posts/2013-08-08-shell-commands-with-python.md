---
title: "shell commands with python"
---

##cmd_utils - Easier Shell Commands with Python##
Here at Graze we use puppet to handle all our server configuration, but we still find plenty of times when we need to run scripts outside of puppet. Whether it's for deploying code, running those one off commands or running one command over every server to check something there's always the need for scripting shell commands.

We've chosen to use Python for our scripting when it gets beyond more than a couple of lines of bash. Python gives us flexibility, readability and a nice mix of high level concepts and raw power.

Of course a lot of our older scripts are written in bash and in moving to Python we've lost the simple shell integration previously available. Handling shell commands in Python is just an exercise in rewriting the same boilerplate code to handle the subprocess, output and return code.

For example lets see if there are any changes to a local git repo:

<?prettify?>
    import os
    import subprocess

    working_dir = "/home/mark/a-git-repo"
    command = "git diff-index --quiet HEAD --"

    os.chdir(working_dir)
    ps = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    output = ps.communicate()[0]
    return_code = ps.returncode

    if return_code != 0:
        raise Exception()



Or in bash:

<?prettify?>
    WORKING_DIR="/home/mark/a-git-repo"
    COMMAND="git diff-index --quiet HEAD --"

    OUTPUT=`cd $WORKING_DIR && $COMMAND`
    RETURN_CODE=$?

    if [ $RETURN_CODE -ne 0 ]; then
        echo "Error Occured"
        exit 1
    fi

Obviously we gain much better error handling with Python but the amount of code required to run one command is larger, a fact especially noticable when you run a lot of commands.

Since we have multiple servers we also need to do remote commands, the paramiko module for Python handles SSH well but once again requires a lot of code:

<?prettify?>
    import paramiko

    host = host.example.com
    username = mark
    working_dir = "/home/mark/a-git-repo"
    command = "git diff-index --quiet HEAD --"

    ssh = paramiko.SSHClient()
    # Auto add missing host keys
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(host, username=username)

    cmd = "cd %s && %s" % (working_dir, command)
    stdin, stdout, stderr = ssh.exec_command(cmd)
    return_code = stdout.channel.recv_exit_status()

    if return_code != 0:
        raise Exception()

This is where our new Python module cmd_utils comes in; it's a small wrapper module for subprocess and paramiko that turns the code above into this:

<?prettify?>
    import cmd_utils

    working_dir = "/home/mark/a-git-repo"
    command = "git diff-index --quiet HEAD --"

    output = cmd_utils.run_cmd(command, target_dir)


and remote:

<?prettify?>
    import cmd_utils

    host = "host.example.com"
    username = "mark"
    working_dir = "/home/mark/a-git-repo"
    command = "git diff-index --quiet HEAD --"

    output = cmd_utils.run_cmd(host, username, command, working_dir)



Cleaner, easier and quicker to write. It also has the option to handle a non-zero return code as an error (on by default) and instead of a single command it can also take a list.

The module is available on [GitHub] and [PyPI], to see examples [click here].

<!-- Links -->
[github]:https://github.com/graze/pycmd-utils
[pypi]:https://pypi.python.org/pypi/cmd_utils
[click here]:https://github.com/graze/pycmd-utils/blob/master/examples.py

> by [Mark Egan-Fuller](https://github.com/markeganfuller)