hello-world:
  file.managed:
    - name: /home/vagrant/hello-world.txt
    - contents: 'Hello World'

/home/vagrant/another-file.txt:
  file.managed:
    - name: /home/vagrant/hello-world.txt
    - contents: 'Hello World in another file'

/home/vagrant/file-by-id.txt:
  file.managed:
    - contents: 'Hello World in file by id'
