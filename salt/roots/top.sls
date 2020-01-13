base:
  '*':
    - init

  'salt':
    - saltmaster

  'os:windows':
    - match: grain
    - win
