import pwd, subprocess
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

import os, nativeauthenticator
c.JupyterHub.template_paths = [f"{os.path.dirname(nativeauthenticator.__file__)}/templates/"]

c.Authenticator.admin_users = {'admin'}

def pre_spawn_hook(spawner):
    username = spawner.user.name
    try:
        pwd.getpwnam(username)
    except KeyError:
        subprocess.check_call(['useradd', '-ms', '/bin/bash', username])
c.Spawner.pre_spawn_hook = pre_spawn_hook
c.Spawner.default_url = '/lab'
c.Spawner.mem_limit = '500MB'
c.NativeAuthenticator.open_signup = True
c.NativeAuthenticator.minimum_password_length = 10
c.NativeAuthenticator.check_common_password = True
c.NativeAuthenticator.allowed_failed_logins = 5
c.NativeAuthenticator.seconds_before_next_try = 1200