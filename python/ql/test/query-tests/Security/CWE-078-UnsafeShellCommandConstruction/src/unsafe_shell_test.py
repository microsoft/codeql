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

import tempfile

def executed_named_temporary_script(name): # $ Source
    with tempfile.NamedTemporaryFile(mode="w") as script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name # $ Alert result=BAD
        script.write(script_text)
        subprocess.Popen(["/bin/bash", script.name])

    with tempfile.NamedTemporaryFile(mode="w") as retry_script:
        retry_text = f"printf '%s\n' {name}" # $ Alert result=BAD
        retry_script.writelines([retry_text])
        subprocess.run(["sh", retry_script.name])

    with tempfile.NamedTemporaryFile(mode="w") as fixed_script:
        fixed_script.write("#!/bin/bash\nprintf '%s\n' fixed")
        subprocess.Popen(["/bin/bash", fixed_script.name]) # OK - fixed script contents

    with tempfile.NamedTemporaryFile(mode="w") as sanitized_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + shlex.quote(name) # $ result=OK
        sanitized_script.write(script_text)
        subprocess.Popen(["/bin/bash", sanitized_script.name]) # OK - sanitized at interpolation

    with tempfile.NamedTemporaryFile(mode="w") as unexecuted_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        unexecuted_script.write(script_text) # OK - never executed

    with tempfile.NamedTemporaryFile(mode="w") as written_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        written_script.write(script_text)
        with tempfile.NamedTemporaryFile(mode="w") as executed_script:
            executed_script.write("#!/bin/bash\nprintf '%s\n' fixed")
            subprocess.Popen(["/bin/bash", executed_script.name]) # OK - different file

    with tempfile.NamedTemporaryFile(mode="w") as non_shell_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        non_shell_script.write(script_text)
        subprocess.Popen(["python", non_shell_script.name]) # OK - non-shell consumer

    with tempfile.NamedTemporaryFile(mode="w") as dynamic_shell_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        dynamic_shell_script.write(script_text)
        shell = "/bin/bash"
        subprocess.Popen([shell, dynamic_shell_script.name]) # OK - dynamic executable

    with tempfile.NamedTemporaryFile(mode="w") as indirect_shell_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        indirect_shell_script.write(script_text)
        subprocess.Popen(["/bin/bash", indirect_shell_script.name], shell=True) # OK - indirect shell invocation

    with tempfile.NamedTemporaryFile(mode="w") as copied_name_script:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        copied_name_script.write(script_text)
        copied_name = copied_name_script.name
        subprocess.Popen(["/bin/bash", copied_name]) # OK - copied filename

    with tempfile.NamedTemporaryFile(mode="w") as written_after_execution:
        script_text = "#!/bin/bash\nprintf '%s\n' " + name
        subprocess.Popen(["/bin/bash", written_after_execution.name])
        written_after_execution.write(script_text) # OK - content was not present when executed

    with tempfile.NamedTemporaryFile(mode="w") as positional_arg_script:
        positional_arg_script.write("#!/bin/bash\nprintf '%s\n' \"$1\"")
        subprocess.Popen(["/bin/bash", positional_arg_script.name, name]) # OK - data is an argument
