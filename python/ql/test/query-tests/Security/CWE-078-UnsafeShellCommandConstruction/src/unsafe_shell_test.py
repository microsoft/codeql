import os
import subprocess

def unsafe_shell_one(name): # $ Source
    os.system("ping " + name) # $ Alert result=BAD

    # f-strings
    os.system(f"ping {name}") # $ Alert result=BAD

    # array.join
    os.system("ping " + " ".join(name)) # $ Alert result=BAD

    # array.join, with a list
    os.system("ping " + " ".join([name])) # $ Alert result=BAD

    # format, using .format
    os.system("ping {}".format(name)) # $ Alert result=BAD

    # format, using %
    os.system("ping %s" % name) # $ Alert result=BAD

    os.system(name) # OK - seems intentional.

import fabric

def facbric_stuff (name): # $ Source
    fabric.api.run("ping " + name, shell=False) # OK

    fabric.api.run("ping " + name, shell=True) # $ Alert result=BAD

    def indirect(flag):
        fabric.api.run("ping " + name, shell=flag) # OK

    indirect(False)

def subprocess_flag (name): # $ Source
    subprocess.run("ping " + name, shell=False) # OK - and nonsensical

    subprocess.run("ping " + name, shell=True) # $ Alert result=BAD

    def indirect(flag, x):
        subprocess.run("ping " + x, shell=flag) # $ Alert result=BAD

    indirect(True, name)

    subprocess.Popen("ping " + name, shell=unknownValue) # OK - shell assumed to be False

def intentional(command):
    os.system("fish -ic " + command) # $ result=OK - intentional

import shlex
def unsafe_shell_sanitized(name):
    os.system("ping " + shlex.quote(name)) # $ result=OK - sanitized

import asyncio

async def explicit_shell_command_operands(name): # $ Source
    popen_command = "ping " + name # $ Alert result=BAD
    subprocess.Popen(["/bin/bash", "-c", popen_command])

    run_command = "ping " + name # $ Alert result=BAD
    subprocess.run(["cmd.exe", "/c", run_command])

    asyncio_command = "ping " + name # $ Alert result=BAD
    await asyncio.create_subprocess_exec("sh", "-c", asyncio_command)

    ordinary_argument = "ping " + name
    subprocess.Popen(["sh", ordinary_argument])

    python_code = "print(" + name + ")"
    subprocess.Popen(["python", "-c", python_code])

    custom_path_command = "ping " + name
    subprocess.Popen(["/opt/tools/bash", "-c", custom_path_command])

    positional_argument = "ping " + name
    subprocess.Popen(["bash", "-c", "echo fixed", positional_argument])

    executable = "bash" if unknownValue else "sh"
    dynamic_executable_command = "ping " + name
    subprocess.Popen([executable, "-c", dynamic_executable_command])
