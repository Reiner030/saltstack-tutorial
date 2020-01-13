
update-windows-git-repositories:
  cmd.run:
    - name: salt-run winrepo.update_git_repos
    - watch_in:
        - cmd: refresh_db-windows-instances

refresh_db-windows-instances:
  cmd.wait:
    - name: salt -G 'os:windows' pkg.refresh_db -t 300
