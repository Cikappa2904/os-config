import subprocess
import os

userEmail = input("Please insert your GitHub email: ")
sshPath = input("Insert the path where to put the SSH file (default: ~/.ssh/id_ed25519): ") or os.path.join(os.path.expanduser('~'), ".ssh", "id_ed25519")
subprocess.run(['ssh-keygen', '-t', 'ed25519', '-C', userEmail, '-f', sshPath])
os.system('eval "$(ssh-agent -s)"')
subprocess.run(["ssh-add", sshPath])
print("Here's the SSH key to copy to GitHub: ")
subprocess.run(["cat", sshPath + ".pub"])