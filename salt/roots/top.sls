base:
  '*':
    - init

  'ubuntu':
    - ethercalc

  'salt':
    - saltmaster

  'os:windows':
    - match: grain
    - win
