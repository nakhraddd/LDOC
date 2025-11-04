# to create groups and roles
import subprocess

roles = {
    "automation": "automation_bot",
    "backend": "backend_user",
    "visual": "visual_user",
    "data": "data_user",
}

def run_cmd(cmd):
    print(f"Running: {cmd}")
    subprocess.run(cmd, shell=True, check=True)

# Create groups
for group in roles.keys():
    run_cmd(f"sudo groupadd -f {group}")

# Create users if not exists
for group, user in roles.items():
    try:
        subprocess.run(f"id -u {user}", shell=True, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        run_cmd(f"sudo useradd -m -s /bin/bash -g {group} {user}")

# to give permission to automation_bot
sudo chown -R automation_bot:automation /home/automation_bot/.ssh
sudo chmod 700 /home/automation_bot/.ssh
sudo chmod 600 /home/automation_bot/.ssh/authorized_keys
